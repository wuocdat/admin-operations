import 'package:conversation_repository/conversation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/core/utils/constants.dart';
import 'package:tctt_mobile/features/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/features/conversation/bloc/conversation_bloc.dart';
import 'package:tctt_mobile/features/conversation/widgets/chat_item.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/core/utils/extensions.dart';
import 'package:tctt_mobile/shared/widgets/inputs.dart';
import 'package:tctt_mobile/shared/widgets/loader.dart';
import 'package:tctt_mobile/shared/widgets/rich_list_view.dart';
import 'package:file_picker/file_picker.dart' as picker;

class ConversationPage extends StatelessWidget {
  const ConversationPage(this.conversationId, {super.key});

  static MaterialPageRoute route(String conversationId) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => ConversationBloc(
          conversationRepository:
              RepositoryProvider.of<ConversationRepository>(context),
          conversationId: conversationId,
        )
          ..add(const DataFetchedEvent())
          ..add(const ConversationInfoFetchedEvent()),
        child: ConversationPage(conversationId),
      ),
    );
  }

  final String conversationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          title: BlocConsumer<ConversationBloc, ConversationState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status.isFailure || state.headerStatus.isFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                      const SnackBar(content: Text('Đã xảy ra lỗi')));
              }
            },
            builder: (context, state) {
              return !state.headerStatus.isSuccess
                  ? const Loader(size: 20, strokeWith: 2)
                  : Text(
                      state.conversationInfo
                          .getName(context.select(
                              (AuthenticationBloc bloc) => bloc.state.user.id))
                          .capitalize(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                      ),
                    );
            },
          ),
          // subtitle: Text(
          //   'Ngũ Hành Sơn, Đà Nẵng $conversationId',
          //   style: TextStyle(
          //     color: Colors.grey[600],
          //     fontSize: 12,
          //   ),
          // ),
        ),
        actions: const [
          // Padding(
          //   padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
          //   child: IconButton(
          //     onPressed: () => ScaffoldMessenger.of(context)
          //       ..hideCurrentSnackBar()
          //       ..showSnackBar(const SnackBar(
          //           content: Text('Tính năng đang được phát triển'))),
          //     icon: const Icon(Icons.more_horiz),
          //     iconSize: 30,
          //   ),
          // ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                child: BlocBuilder<ConversationBloc, ConversationState>(
                  builder: (context, state) {
                    return RichListView(
                      reverse: true,
                      hasReachedMax: state.hasReachedMax,
                      itemCount: state.messages.length,
                      itemBuilder: (index) => ChatItem(state.messages[index]),
                      onReachedEnd: () => context
                          .read<ConversationBloc>()
                          .add(const DataFetchedEvent()),
                    );
                  },
                ),
              ),
            ),
            BlocBuilder<ConversationBloc, ConversationState>(
              builder: (context, state) {
                return state.files.isNotEmpty
                    ? AttachNoticeContainer(
                        onTap: () => context
                            .read<ConversationBloc>()
                            .add(FilesCleared()),
                      )
                    : Container();
              },
            ),
            BottomActionContainer()
          ],
        ),
      ),
    );
  }
}

class AttachNoticeContainer extends StatelessWidget {
  const AttachNoticeContainer({super.key, this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          const Icon(Icons.image),
          const SizedBox(width: 16),
          Expanded(child: const Text('Đang đính kèm 1 file')),
          IconButton(onPressed: onTap, icon: const Icon(Icons.close))
        ],
      ),
    );
  }
}

const int _maxFileSizeInMb = 20 * 1024 * 1024;

class BottomActionContainer extends StatelessWidget {
  BottomActionContainer({
    super.key,
  });

  final controller = TextEditingController();

  Future<List<picker.PlatformFile>?> _onTap() async {
    try {
      picker.FilePickerResult? result =
          await picker.FilePicker.platform.pickFiles(
        type: picker.FileType.custom,
        allowedExtensions: List.from(allowedImageExtensions)
          ..addAll(allowedVideoExtensions),
      );

      if (result != null) {
        final files = result.files.nonNulls
            .where((element) => element.size <= _maxFileSizeInMb)
            .toList();
        if (files.length > 5) {
          files.removeRange(5, files.length);
        }
        return files;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: BlocBuilder<ConversationBloc, ConversationState>(
        builder: (context, state) {
          return Row(
            children: [
              IconButton(
                onPressed: () async {
                  final resultFiles = await _onTap();

                  if (resultFiles == null || !context.mounted) return;

                  if (resultFiles.isEmpty) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(const SnackBar(
                          content: Text('Kích thước file phải nhỏ hơn 20MB')));
                    return;
                  }

                  context.read<ConversationBloc>().add(FilePicked(resultFiles));
                },
                icon: const Icon(Icons.attach_file),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: BorderInput(
                  controller: controller,
                  hintText: 'Tin nhắn',
                  onChanged: (value) => context
                      .read<ConversationBloc>()
                      .add(MessageTextInputChangedEvent(value)),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed:
                    state.currentInputText.isNotEmpty || state.files.isNotEmpty
                        ? () {
                            controller.clear();
                            context
                                .read<ConversationBloc>()
                                .add(const MessageSentEvent());
                            context
                                .read<ConversationBloc>()
                                .add(const MessageTextInputChangedEvent(""));
                          }
                        : null,
                icon: const Icon(Icons.send),
              ),
            ],
          );
        },
      ),
    );
  }
}
