import 'package:api_client/src/api_config.dart';
import 'package:api_client/src/common/handlers.dart';
import 'package:api_client/src/units/models/models.dart';
import 'package:api_client/src/units/path.dart';
import 'package:dio/dio.dart';

class UnitsApiClient {
  UnitsApiClient({Dio? dio})
      : _dio = dio ?? Dio(ApiConfig.options)
          ..interceptors.add(ApiInterceptors());

  final Dio _dio;

  Future<List<Unit>> getUnitsByParentId(String parentId) async {
    final response = await _dio.get(UnitsUrl.getUnits, queryParameters: {
      'parentUnit': parentId,
    });

    final result = Handler.parseResponse(response) as List;

    return result.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return Unit.fromJson(map);
    }).toList();
  }
}
