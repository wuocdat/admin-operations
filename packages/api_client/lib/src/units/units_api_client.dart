import 'package:api_client/src/api_config.dart';
import 'package:api_client/src/common/handlers.dart';
import 'package:api_client/src/units/path.dart';
import 'package:dio/dio.dart';

class NewUnitFailure implements Exception {}

class DeleteUnitFailure implements Exception {}

class UnitsApiClient {
  UnitsApiClient({Dio? dio})
      : _dio = dio ?? Dio(ApiConfig.options)
          ..interceptors.add(ApiInterceptors());

  final Dio _dio;

  Future<void> createUnit(String name, String parentUnit, String type) async {
    final response = await _dio.post(UnitsUrl.getUnits, data: {
      "name": name,
      "parentUnit": parentUnit,
      "type": type,
    });

    if (response.statusCode != 201) throw NewUnitFailure();
  }

  Future<void> deleteUnitById(String id) async {
    final response = await _dio.delete("${UnitsUrl.getUnits}/$id");

    if (response.statusCode != 200) throw DeleteUnitFailure();
  }

  Future<List> getChildrenUnitTypes(String parentTypeId) async {
    final response =
        await _dio.get("${UnitsUrl.getChildrenUnitTypes}$parentTypeId");

    final result = Handler.parseResponse(response) as List;

    return result;
  }

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
