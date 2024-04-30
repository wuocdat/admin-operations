import 'package:api_client/src/api_config.dart';
import 'package:api_client/src/common/handlers.dart';
import 'package:api_client/src/mail/path.dart';
import 'package:dio/dio.dart';

class MailNotFoundFailure implements Exception {}

class MailApiClient {
  MailApiClient({Dio? dio})
      : _dio = dio ?? Dio(ApiConfig.options)
          ..interceptors.add(ApiInterceptors());

  final Dio _dio;

  Future<Map<String, dynamic>> getOverall() async {
    final response = await _dio.get(MailUrl.overall);

    final result = Handler.parseResponse(response) as Map<String, dynamic>;

    if (!result.containsKey('inbox')) throw MailNotFoundFailure();

    return result['inbox'] as Map<String, dynamic>;
  }
}
