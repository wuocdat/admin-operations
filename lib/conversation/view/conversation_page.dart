import 'package:flutter/material.dart';
import 'package:tctt_mobile/conversation/widgets/chat_item.dart';
import 'package:tctt_mobile/shared/utils/constants.dart';
import 'package:tctt_mobile/widgets/inputs.dart';

class Conversation extends StatelessWidget {
  const Conversation({super.key});

  static MaterialPageRoute route(String conversationId) {
    return MaterialPageRoute(
      builder: (context) => const Conversation(),
    );
  }

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
          title: const Text(
            'Nguyễn Văn A',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.bold,
              letterSpacing: 0,
            ),
          ),
          subtitle: Text(
            'Ngũ Hành Sơn, Đà Nẵng',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: IconButton(
              onPressed: () {
                // navigate to settings page
              },
              icon: const Icon(Icons.more_horiz),
              iconSize: 30,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                child: const Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ChatItem(
                      senderName: "Lăng Kỳ Thiên",
                      time: '8:16 PM',
                      origin: MessageOrigin.fromOther,
                      text: mockMessageText,
                    ),
                    ChatItem(
                      time: '8:16 PM',
                      origin: MessageOrigin.fromSelf,
                      text: mockMessageText,
                    ),
                    ChatItem(
                      time: '8:16 PM',
                      origin: MessageOrigin.fromSelf,
                      attachmentUrl: mockMessageText,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.attach_file),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: BorderInput(
                      hintText: 'Tin nhắn',
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
