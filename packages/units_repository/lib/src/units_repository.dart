import 'package:api_client/api_client.dart';
import 'package:units_repository/src/models/models.dart';

class UnitsRepository {
  UnitsRepository({UnitsApiClient? unitsApiClient})
      : _unitsApiClient = unitsApiClient ?? UnitsApiClient();

  final UnitsApiClient _unitsApiClient;

  Future<List<Unit>> getUnitsByParentId(String parentId) async {
    final units = await _unitsApiClient.getUnitsByParentId(parentId);

    return units
        .map((unit) => Unit(
            id: unit.id,
            name: unit.name,
            createdBy: unit.createdBy,
            createdAt: unit.createdAt,
            isActive: unit.isActive))
        .toList();
  }
}
