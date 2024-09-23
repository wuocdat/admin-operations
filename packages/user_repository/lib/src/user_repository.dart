import 'package:api_client/api_client.dart';
import 'package:user_repository/src/models/models.dart';

const userLimit = 20;

class UserRepository {
  UserRepository({UserApiClient? userApiClient})
      : _apiClient = userApiClient ?? UserApiClient();

  final UserApiClient _apiClient;

  Future<User> getUser() async {
    final userData = await _apiClient.getUser();

    return User.fromJson(userData);
  }

  Future<void> createUser(String name, String username, String unitId,
      String password, String role) async {
    await _apiClient.createNewUser(name, username, password, unitId, role);
  }

  Future<void> deleteUser(String userId) async {
    await _apiClient.deleteUser(userId);
  }

  Future<List<ShortProfile>> searchUsers(String username,
      [int length = 0]) async {
    final jsonUsers = await _apiClient.searchUsers(
      username,
      userLimit,
      (length / userLimit).ceil() + 1,
    );

    return jsonUsers
        .map((e) => ShortProfile.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ShortProfile>> fetchUsersByUnitId(String unitId,
      [int length = 0]) async {
    final jsonUsers = await _apiClient.fetchUnitUsers(
      unitId,
      userLimit,
      (length / userLimit).ceil() + 1,
    );

    return jsonUsers
        .map((e) => ShortProfile.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ShortProfile>> getChatUsersByUnitId(String unitId) async {
    final jsonUsers = await _apiClient.getUsersByUnitId(unitId);

    return jsonUsers
        .map((e) => ShortProfile.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
