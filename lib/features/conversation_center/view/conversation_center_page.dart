import 'package:conversation_repository/conversation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/features/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/features/conversation/view/conversation_page.dart';
import 'package:tctt_mobile/features/conversation_center/cubit/conversation_center_cubit.dart';
import 'package:tctt_mobile/features/search_user/view/search_user_page.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/core/utils/extensions.dart';
import 'package:tctt_mobile/core/utils/time.dart';
import 'package:tctt_mobile/shared/widgets/images.dart';
import 'package:tctt_mobile/shared/widgets/label_text.dart';
import 'package:tctt_mobile/shared/widgets/loader.dart';

class ConversationCenter extends StatelessWidget {
  const ConversationCenter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => ConversationCenterCubit(
        conversationRepository:
            RepositoryProvider.of<ConversationRepository>(context),
      )..fetchConversations(),
      child: BlocBuilder<ConversationCenterCubit, ConversationCenterState>(
        builder: (context, state) {
          switch (state.status) {
            case FetchDataStatus.loading:
              return const Loader();
            default:
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: () async {
                      await Navigator.of(context).push(SearchUser.route());

                      if (!context.mounted) return;

                      context
                          .read<ConversationCenterCubit>()
                          .fetchConversations();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: theme.primaryColor.withOpacity(0.1),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 8),
                          Text('Tìm kiếm tên người dùng hoặc số điện thoại'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => context
                          .read<ConversationCenterCubit>()
                          .fetchConversations(),
                      child: ListView.builder(
                        itemCount: state.conversations.length,
                        itemBuilder: (_, index) {
                          final conversation = state.conversations[index];
                          return conversation.lastestMessage != null ||
                                  conversation.conversationUsers.length > 2
                              ? ConversationItem(
                                  conversation: conversation,
                                  onTap: () async {
                                    await Navigator.of(context).push(
                                        ConversationPage.route(
                                            conversation.id));

                                    if (!context.mounted) return;

                                    context
                                        .read<ConversationCenterCubit>()
                                        .fetchConversations();
                                  },
                                )
                              : Container();
                        },
                      ),
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}

class ConversationItem extends StatelessWidget {
  const ConversationItem({
    super.key,
    this.lastIsImage = false,
    this.isLast = false,
    this.onTap,
    required this.conversation,
  });

  final Conversation conversation;
  final bool lastIsImage;
  final bool isLast;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: !isLast
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
              )
            : null,
        child: BlocSelector<AuthenticationBloc, AuthenticationState, String>(
          selector: (state) {
            return state.user.id;
          },
          builder: (context, userId) {
            final name = conversation.getName(userId).capitalize();
            return ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              leading: SmartAvatar(text: name),
              title: MediumLabelText(
                name,
                color: theme.primaryColor,
              ),
              subtitle: lastIsImage
                  ? const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_rounded, size: 16),
                        SizedBox(width: 8),
                        Text('Photo'),
                      ],
                    )
                  : Text(
                      conversation.lastMessageContent,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
              trailing: Column(
                children: [
                  Text(
                    conversation.lastMessageTime,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

extension on Conversation {
  String get lastMessageContent {
    return switch (lastestMessage?.type) {
      EMessageType.text => lastestMessage?.content ?? '',
      EMessageType.image => 'Tin nhắn hình ảnh',
      EMessageType.video => 'Tin nhắn video',
      _ => 'Chưa có tin nhắn nào',
    };
  }

  String get lastMessageTime => lastMessageCreatedAt != null
      ? TimeUtils.convertTimeToReadableFormat(lastMessageCreatedAt!)
      : "";
}
