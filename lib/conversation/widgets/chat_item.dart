import 'package:conversation_repository/conversation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/shared/utils/time.dart';
import 'package:tctt_mobile/widgets/images.dart';
import 'package:tctt_mobile/widgets/label_text.dart';

enum MessageSide { otherSide, mySide }

extension MessageOriginX on MessageSide {
  bool get isFromOther => this == MessageSide.otherSide;
}

class ChatItem extends StatelessWidget {
  const ChatItem(this.message, {super.key});
  final Message message;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final otherSide = context.select(
        (AuthenticationBloc bloc) => bloc.state.user.id != message.createdBy);

    final senderName = message.userData['name'];

    final List<TextSpan> headTextSpans = [
      TextSpan(
        text: otherSide ? senderName : 'Bạn',
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      const TextSpan(text: '   '),
      TextSpan(
        text: TimeUtils.formatTime(message.createdAt),
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
          textAlign: otherSide ? TextAlign.left : TextAlign.right,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children:
                otherSide ? headTextSpans : headTextSpans.reversed.toList(),
          ),
        ),
      )
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment:
            otherSide ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment:
                otherSide ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: otherSide ? itemHeader : itemHeader.reversed.toList(),
          ),
          const SizedBox(height: 8),
          ContentChatContainer(
              screenSize: screenSize,
              origin: otherSide ? MessageSide.otherSide : MessageSide.mySide,
              text: message.content,
              attachmentUrl: null),
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
  final MessageSide origin;
  final String? text;
  final String? attachmentUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: origin.isFromOther ? 0 : screenSize.width * 0.15,
        right: !origin.isFromOther ? 0 : screenSize.width * 0.15,
      ),
      child: Container(
        // width: screenSize.width * 0.8,
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
        child:
            (attachmentUrl != null) ? const ChatFileItem() : Text(text ?? ''),
      ),
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
