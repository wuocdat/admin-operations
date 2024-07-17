import 'package:api_client/src/api_config.dart';
import 'package:api_client/src/common/handlers.dart';
import 'package:api_client/src/units/path.dart';
import 'package:dio/dio.dart';

class UnitsApiClient {
  UnitsApiClient({Dio? dio})
      : _dio = dio ?? Dio(ApiConfig.options)
          ..interceptors.add(ApiInterceptors());

  final Dio _dio;

  Future<Map<String, dynamic>> getUnitDetailById(String unitId) async {
    final response = await _dio.get("${UnitsUrl.getUnits}/$unitId");

    final result = Handler.parseResponse(response) as Map<String, dynamic>;

    return result;
  }

  Future<List<Map<String, dynamic>>> getUnitsByParentId(String parentId) async {
    final response = await _dio.get(UnitsUrl.getUnits, queryParameters: {
      'parentUnit': parentId,
    });

    final result = Handler.parseResponse(response) as List;

    return result.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return map;
    }).toList();
  }
}
