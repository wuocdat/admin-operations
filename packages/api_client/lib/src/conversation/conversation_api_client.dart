import 'package:api_client/src/api_config.dart';
import 'package:api_client/src/common/handlers.dart';
import 'package:api_client/src/conversation/path.dart';
import 'package:dio/dio.dart';

class ConversationNotFoundFailure implements Exception {}

class MessagesNotFoundFailure implements Exception {}

class ConversationApiClient {
  ConversationApiClient({Dio? dio})
      : _dio = dio ?? Dio(ApiConfig.options)
          ..interceptors.add(ApiInterceptors());

  final Dio _dio;

  Future<List> getConversations() async {
    final response = await _dio.get(ConversationUrl.base);

    if (response.statusCode != 200) throw ConversationNotFoundFailure();

    final data = response.data as List;

    return data;
  }

  Future<Map<String, dynamic>> getConversationById(String id) async {
    final response = await _dio.get('${ConversationUrl.base}/$id');

    if (response.statusCode != 200) throw ConversationNotFoundFailure();

    final data = response.data as Map<String, dynamic>;

    return data;
  }

  Future<List> getMessagesByConversationId(String id, int limit,
      [int currentPage = 1]) async {
    final response = await _dio.get(ConversationUrl.messages, queryParameters: {
      "_id": id,
      'limit': limit,
      "page": currentPage,
    });

    final jsonResult = Handler.parseResponse(response) as Map<String, dynamic>;

    if (!jsonResult.containsKey('messages')) throw MessagesNotFoundFailure();

    final messages = jsonResult['messages'] as List;

    return messages;
  }
}
