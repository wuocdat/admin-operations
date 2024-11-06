import 'package:api_client/src/api_config.dart';
import 'package:api_client/src/common/handlers.dart';
import 'package:api_client/src/conversation/path.dart';
import 'package:dio/dio.dart';

class ConversationNotFoundFailure implements Exception {}

class MessagesNotFoundFailure implements Exception {}

class MessageFilesUploadingFailure implements Exception {}

class ConversationApiClient {
  ConversationApiClient({Dio? dio})
      : _dio = dio ?? Dio(ApiConfig.options)
          ..interceptors.add(ApiInterceptors());

  final Dio _dio;

  Future<List> getConversations() async {
    final response = await _dio.get(ConversationUrl.list);

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

  Future<List> uploadMessageFile(List<String> filePaths, String type) async {
    final formData = FormData.fromMap({
      "type": type,
    });

    if (filePaths.isNotEmpty) {
      formData.files.addAll(await Future.wait(filePaths.map((path) async {
        return MapEntry('files', await MultipartFile.fromFile(path));
      })));
    }

    final response = await _dio.post(
      ConversationUrl.uploadFile,
      data: formData,
    );

    if (response.statusCode != 201 || response.data['data'] == null) {
      throw MessageFilesUploadingFailure();
    }

    return response.data['data'] as List;
  }
}
