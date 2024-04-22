import 'package:api_client/api_client.dart';
import 'package:units_repository/src/models/models.dart';

class UnitsRepository {
  UnitsRepository({UnitsApiClient? unitsApiClient})
      : _unitsApiClient = unitsApiClient ?? UnitsApiClient();

  final UnitsApiClient _unitsApiClient;

  Future<List<Unit>> getUnitsByParentId(String parentId) async {
    final units = await _unitsApiClient.getUnitsByParentId(parentId);

    return units.map((e) => Unit.fromJson(e)).toList();
  }
}
