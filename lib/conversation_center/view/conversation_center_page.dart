import 'package:flutter/material.dart';
import 'package:tctt_mobile/conversation/view/conversation_page.dart';
import 'package:tctt_mobile/search_user/view/search_user_page.dart';
import 'package:tctt_mobile/widgets/images.dart';
import 'package:tctt_mobile/widgets/label_text.dart';

class ConversationCenter extends StatelessWidget {
  const ConversationCenter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).push(SearchUser.route()),
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
          ConversationItem(
            onTap: () => Navigator.of(context)
                .push(Conversation.route('conversationId')),
          ),
          const ConversationItem(lastIsImage: true),
          const ConversationItem(),
          const ConversationItem(isLast: true),
        ],
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
  });

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
          leading: const DemoAvatar(),
          title: MediumLabelText(
            'Lăng Kỳ Thiên',
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
