import 'package:api_client/api_client.dart';
import 'package:user_repository/src/models/user.dart';

class UserRepository {
  UserRepository({UserApiClient? userApiClient})
      : _apiClient = userApiClient ?? UserApiClient();

  final UserApiClient _apiClient;

  Future<User> getUser() async {
    final userData = await _apiClient.getUser();

    return User.fromJson(userData);
  }
}
