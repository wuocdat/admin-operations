import 'dart:convert';

import 'package:api_client/src/api_config.dart';
import 'package:api_client/src/common/handlers.dart';
import 'package:api_client/src/mail/path.dart';
import 'package:dio/dio.dart';

class MailNotFoundFailure implements Exception {}

class MailRequestFailure implements Exception {}

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
      "sortBy": jsonEncode({
        "createdAt": -1,
      })
    });

    final result = Handler.parseResponse(response) as List;

    return result;
  }

  Future<List> getSentMails(int limit, [int currentPage = 1]) async {
    final response = await _dio.get(MailUrl.sentMail, queryParameters: {
      "pageSize": limit,
      "currentPage": currentPage,
      "sortBy": jsonEncode({
        "createdAt": -1,
      })
    });

    final result = Handler.parseResponse(response) as List;

    return result;
  }

  Future<Map<String, dynamic>> getReceivedMailDetail(String maiId) async {
    final response = await _dio.get("${MailUrl.receivedMail}/$maiId");

    final result = Handler.parseResponse(response) as Map<String, dynamic>;

    return result;
  }

  Future<Map<String, dynamic>> getSentMailDetail(String maiId) async {
    final response = await _dio.get("${MailUrl.sentMail}/$maiId");

    final result = Handler.parseResponse(response) as Map<String, dynamic>;

    return result;
  }

  Future<Map<String, dynamic>?> getNewestMail() async {
    final response = await _dio.get("${MailUrl.receivedMail}/latest-unreads");

    final result = Handler.parseResponse(response) as Map<String, dynamic>?;

    return result;
  }

  Future<void> createMail(String name, String content, bool important,
      List<String> units, List<String> filePaths) async {
    final formData = FormData.fromMap({
      'name': name,
      'content': content,
      'important': important,
    });

    formData.fields.addAll(units.map((unit) {
      return MapEntry('receivers[]', unit);
    }));

    if (filePaths.isNotEmpty) {
      formData.files.addAll(await Future.wait(filePaths.map((path) async {
        return MapEntry('files', await MultipartFile.fromFile(path));
      })));
    }

    final response = await _dio.post(
      MailUrl.original,
      data: formData,
    );

    if (response.statusCode != 201) {
      throw MailRequestFailure();
    }
  }
}
