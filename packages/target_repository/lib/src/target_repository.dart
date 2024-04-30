import 'package:api_client/api_client.dart';
import 'package:target_repository/src/models/target_overall.dart';

class TargetRepository {
  TargetRepository({TargetApiClient? targetApiClient})
      : _targetApiClient = targetApiClient ?? TargetApiClient();

  final TargetApiClient _targetApiClient;

  Future<TargetOverall> getOverall() async {
    final result = await _targetApiClient.getOverall();

    return TargetOverall.fromJson(result);
  }
}
