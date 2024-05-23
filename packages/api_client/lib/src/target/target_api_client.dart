import 'dart:convert';

import 'package:api_client/src/api_config.dart';
import 'package:api_client/src/common/handlers.dart';
import 'package:api_client/src/target/path.dart';
import 'package:dio/dio.dart';

class TargetNotFoundFailure implements Exception {}

class NewTargetFailure implements Exception {}

class DeleteTargetFailure implements Exception {}

class TargetApiClient {
  TargetApiClient({Dio? dio})
      : _dio = dio ?? Dio(ApiConfig.options)
          ..interceptors.add(ApiInterceptors());

  final Dio _dio;

  Future<Map<String, dynamic>> getOverall() async {
    final response = await _dio.get(TargetUrl.overall);

    final result = Handler.parseResponse(response) as Map<String, dynamic>;

    if (!result.containsKey('subject')) throw TargetNotFoundFailure();

    return result['subject'] as Map<String, dynamic>;
  }

  Future<List> fetchSubjects(int typeAct, String? fbTypeId, int limit,
      [int page = 1]) async {
    final queryParameters = {
      'typeAc': typeAct,
      'pageSize': limit,
      'currentPage': page,
      'sortBy': jsonEncode({'name': 1})
    };

    if (fbTypeId != null) queryParameters['type'] = fbTypeId;

    final response = await _dio.get(
      TargetUrl.list,
      queryParameters: queryParameters,
    );

    final result = Handler.parseResponse(response) as List;

    return result;
  }

  Future<Map<String, dynamic>> fetchSubjectById(String subjectId) async {
    final response = await _dio.get('${TargetUrl.list}/$subjectId');

    final result = Handler.parseResponse(response) as Map<String, dynamic>;

    return result;
  }

  Future<void> createSubject(
      String infoName, String type, String typeAc, String uid) async {
    final response = await _dio.post(TargetUrl.list, data: {
      "informalName": infoName,
      "type": type,
      "typeAc": typeAc,
      "uid": uid,
    });

    if (response.statusCode != 201) throw NewTargetFailure();
  }

  Future<void> deleteSubject(String subjectId) async {
    final response = await _dio.delete('${TargetUrl.list}/$subjectId');

    if (response.statusCode != 200) throw DeleteTargetFailure();
  }

  Future<List> fetchPostsBySubjectId(String subjectId, int limit,
      [int page = 1]) async {
    final response = await _dio.get(TargetUrl.posts, queryParameters: {
      'fbSubject': subjectId,
      'pageSize': limit,
      'currentPage': page,
      'sortBy': jsonEncode({'time': -1})
    });

    final result = Handler.parseResponse(response) as List;

    return result;
  }

  Future<List> fetchPostsByType(
      int typeAc, String unitId, String startDate, String endDate, int limit,
      [int page = 1]) async {
    final response = await _dio.get(TargetUrl.posts, queryParameters: {
      'typeAc': typeAc,
      'pageSize': limit,
      'currentPage': page,
      'sortBy': jsonEncode({'time': -1}),
      'unit': unitId,
      'startDate': startDate,
      'endDate': endDate,
    });

    final result = Handler.parseResponse(response) as List;

    return result;
  }
}
