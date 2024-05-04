import 'package:api_client/src/api_config.dart';
import 'package:api_client/src/conversation/path.dart';
import 'package:dio/dio.dart';

class ConversationNotFoundFailure implements Exception {}

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
}
