import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class IAuthServiceTokenStorage {
  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<void> clearToken();
}

class AuthServiceTokenStorage implements IAuthServiceTokenStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  @override
  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  @override
  Future<void> clearToken() async {
    await _storage.delete(key: 'auth_token');
  }
}
