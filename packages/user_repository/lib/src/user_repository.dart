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

  Future<List<User>> getUserbyUnitID(String unitId, int pagesize, [int currentpage = 1]) async {
    final userdata = await _apiClient.getAllUsers(unitId, pagesize, currentpage);

    return userdata.map((e) => User.fromJson(e)).toList();
  }
}
