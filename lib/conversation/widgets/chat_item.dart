import 'package:flutter/material.dart';
import 'package:tctt_mobile/widgets/images.dart';
import 'package:tctt_mobile/widgets/label_text.dart';

enum MessageOrigin { fromOther, fromSelf }

extension MessageOriginX on MessageOrigin {
  bool get isFromOther => this == MessageOrigin.fromOther;
}

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    this.senderName,
    this.text,
    this.attachmentUrl,
    required this.time,
    required this.origin,
  });

  final String? senderName;
  final String? text;
  final String? attachmentUrl;
  final String time;
  final MessageOrigin origin;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final List<TextSpan> headTextSpans = [
      TextSpan(
        text: '${origin.isFromOther ? senderName : 'Bạn'}',
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      const TextSpan(text: '   '),
      TextSpan(
        text: time,
        style: const TextStyle(
          fontSize: 12,
          fontStyle: FontStyle.italic,
          color: Colors.grey,
        ),
      ),
    ];

    final List<Widget> itemHeader = [
      const DemoAvatar(size: 35),
      const SizedBox(width: 8),
      Expanded(
        child: RichText(
          textAlign: origin.isFromOther ? TextAlign.left : TextAlign.right,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: origin.isFromOther
                ? headTextSpans
                : headTextSpans.reversed.toList(),
          ),
        ),
      )
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: origin.isFromOther
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: origin.isFromOther
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children:
                origin.isFromOther ? itemHeader : itemHeader.reversed.toList(),
          ),
          const SizedBox(height: 8),
          ContentChatContainer(
              screenSize: screenSize,
              origin: origin,
              text: text,
              attachmentUrl: attachmentUrl),
        ],
      ),
    );
  }
}

class ContentChatContainer extends StatelessWidget {
  const ContentChatContainer({
    super.key,
    required this.screenSize,
    required this.origin,
    this.text,
    this.attachmentUrl,
  });

  final Size screenSize;
  final MessageOrigin origin;
  final String? text;
  final String? attachmentUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width * 0.8,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: origin.isFromOther
            ? Colors.white
            : Theme.of(context).primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.only(
          topLeft: origin.isFromOther
              ? const Radius.circular(2)
              : const Radius.circular(12),
          topRight: !origin.isFromOther
              ? const Radius.circular(2)
              : const Radius.circular(12),
          bottomLeft: const Radius.circular(12),
          bottomRight: const Radius.circular(12),
        ),
      ),
      child: (attachmentUrl != null) ? const ChatFileItem() : Text(text ?? ''),
    );
  }
}

class ChatFileItem extends StatelessWidget {
  const ChatFileItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 0,
        ),
        leading: Icon(Icons.file_present),
        title: Text('Design.psd'),
        subtitle: BodySmallText('243 KB', color: Colors.grey),
        trailing: Icon(Icons.file_download_outlined),
      ),
    );
  }
}
