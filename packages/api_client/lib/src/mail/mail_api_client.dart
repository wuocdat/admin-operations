import 'dart:convert';

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

  Future<List> getReceivedMails(int limit, [int currentPage = 1]) async {
    final response = await _dio.get(MailUrl.receivedMail, queryParameters: {
      "pageSize": limit,
      "currentPage": currentPage,
      "shortBy": jsonEncode({
        "createdAt": -1,
      })
    });

    final result = Handler.parseResponse(response) as List;

    return result;
  }
}
