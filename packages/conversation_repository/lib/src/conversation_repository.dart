import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:conversation_repository/src/models/models.dart';

const messageLimit = 10;

class ConversationRepository {
  ConversationRepository({ConversationApiClient? conversationApiClient})
      : _apiClient = conversationApiClient ?? ConversationApiClient();

  final ConversationApiClient _apiClient;
  final _controller = StreamController<String>.broadcast();

  Stream<String> get notification async* {
    yield* _controller.stream.asBroadcastStream();
  }

  void pushConversationDataToStream(String conversationId) {
    _controller.add(conversationId);
  }

  Future<List<Conversation>> getConversations() async {
    final jsonList = await _apiClient.getConversations();

    return jsonList.map((e) => Conversation.fromJson(e)).toList();
  }

  Future<Conversation> getConversationById(String id) async {
    final jsonConversation = await _apiClient.getConversationById(id);

    return Conversation.fromJson(jsonConversation);
  }

  Future<List<Message>> fetchMessages(String conversationId,
      [int length = 0]) async {
    var page = (length / messageLimit).ceil() + 1;

    if ((length % messageLimit) != 0) {
      page -= 1;
    }
    final jsonList = await _apiClient.getMessagesByConversationId(
      conversationId,
      messageLimit,
      page,
    );

    return jsonList
        .sublist(length % messageLimit)
        .map((e) => Message.fromJson(e))
        .toList();
  }

  Future<List<String>> uploadMessageFiles(
      List<String> filePaths, String type) async {
    final jsonList = await _apiClient.uploadMessageFile(filePaths, type);

    return jsonList.map((e) => e as String).toList();
  }
}
