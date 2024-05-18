import 'package:flutter/material.dart';
import 'package:tctt_mobile/core/utils/extensions.dart';
import 'package:tctt_mobile/core/theme/colors.dart';
import 'package:tctt_mobile/shared/widgets/images.dart';

class PostContainer extends StatelessWidget {
  const PostContainer({
    super.key,
    required this.name,
    required this.time,
    required this.content,
    required this.like,
    required this.comment,
    required this.share,
  });

  final String name;
  final String time;
  final String content;
  final String like;
  final String comment;
  final String share;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: SmartAvatar(text: name),
              title: Text(name),
              subtitle: Text(time),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            ),
            Text(content),
            const SizedBox(height: 8),
            Divider(color: AppColors.secondaryBackground.withOpacity(0.3)),
            Row(
              children: [
                Expanded(child: InfoBox(title: 'lượt thích', amount: like)),
                Expanded(child: InfoBox(title: 'bình luận', amount: comment)),
                Expanded(child: InfoBox(title: 'chia sẻ', amount: share)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  const InfoBox({
    super.key,
    required this.title,
    required this.amount,
  });

  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: <TextSpan>[
          TextSpan(
            text: '${amount.noBlank ?? 0}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: ' $title'),
        ],
      ),
    );
  }
}
