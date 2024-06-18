import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class TokenService {
  static Future<String?> getToken() async {
    final accessToken = await storage.read(key: "access_token");
    return accessToken;
  }
}
