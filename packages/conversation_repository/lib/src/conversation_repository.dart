import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:conversation_repository/src/models/models.dart';

class ConversationRepository {
  ConversationRepository({ConversationApiClient? conversationApiClient})
      : _apiClient = conversationApiClient ?? ConversationApiClient();

  final ConversationApiClient _apiClient;

  Future<List<Conversation>> getConversations() async {
    final jsonList = await _apiClient.getConversations();

    return jsonList.map((e) => Conversation.fromJson(e)).toList();
  }

  Future<List<Message>> fetchMessages(String conversationId) async {
    final jsonList =
        await _apiClient.getMessagesByConversationId(conversationId);

    return jsonList.map((e) => Message.fromJson(e)).toList();
  }
}
