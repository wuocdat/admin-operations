import 'package:api_client/api_client.dart';
import 'package:units_repository/src/models/models.dart';

class UnitsRepository {
  UnitsRepository({UnitsApiClient? unitsApiClient})
      : _unitsApiClient = unitsApiClient ?? UnitsApiClient();

  final UnitsApiClient _unitsApiClient;

  Future<Unit> getUnitById(String unitId) async {
    final unitJson = await _unitsApiClient.getUnitDetailById(unitId);

    return Unit.fromJson(unitJson);
  }

  Future<List<Unit>> getUnitsByParentId(String parentId) async {
    final units = await _unitsApiClient.getUnitsByParentId(parentId);

    return units.map((e) => Unit.fromJson(e)).toList();
  }

  Future<List<UnitType>> getChildrenUnitTypes(String parentUnitTypeId) async {
    final types = await _unitsApiClient.getChildrenUnitTypes(parentUnitTypeId);

    return types.map((e) => UnitType.fromJson(e)).toList();
  }

  Future<void> createUnit(String name, String parentUnit, String type) async {
    await _unitsApiClient.createUnit(name, parentUnit, type);
  }

  Future<void> deleteUnitById(String id) async {
    await _unitsApiClient.deleteUnitById(id);
  }

  Future<List<UnitNode>> getFullUnitTree() async {
    final jsonList = await _unitsApiClient.getFullTree();

    return jsonList.map((json) {
      final unitNode = UnitNode.fromJson(json);
      return unitNode;
    }).toList();
  }
}
