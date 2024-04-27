import 'package:flutter/material.dart';
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
          Container(
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
          const ConversationItem(),
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
  });

  final bool lastIsImage;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
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
    );
  }
}
