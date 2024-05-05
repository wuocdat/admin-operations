import 'package:conversation_repository/conversation_repository.dart'
    hide Conversation;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/conversation/view/conversation_page.dart';
import 'package:tctt_mobile/conversation_center/cubit/conversation_center_cubit.dart';
import 'package:tctt_mobile/search_user/view/search_user_page.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/utils/extensions.dart';
import 'package:tctt_mobile/widgets/images.dart';
import 'package:tctt_mobile/widgets/label_text.dart';
import 'package:tctt_mobile/widgets/loader.dart';

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
      child: SingleChildScrollView(
        child: BlocBuilder<ConversationCenterCubit, ConversationCenterState>(
          builder: (context, state) {
            switch (state.status) {
              case FetchDataStatus.loading:
                return const SizedBox(height: 200, child: Loader());
              default:
                return Column(
                  children: [
                    InkWell(
                      onTap: () =>
                          Navigator.of(context).push(SearchUser.route()),
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
                    ...state.conversations.map(
                      (e) => ConversationItem(
                        name: e
                            .getName(context.select((AuthenticationBloc bloc) =>
                                bloc.state.user.id))
                            .capitalize(),
                        onTap: () => Navigator.of(context)
                            .push(Conversation.route(e.id)),
                      ),
                    ),
                  ],
                );
            }
          },
        ),
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
    required this.name,
  });

  final String name;
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
        child: ListTile(
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
              : const Text(
                  'Gửi đồng chí thông tin về đối tượng Nguyễn Lân Thắng',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
          trailing: Column(
            children: [
              Text(
                '10:30',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
