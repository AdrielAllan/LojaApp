import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/models/user_register_model.dart';
import 'package:usanacaixaapp/data/repositories/auth_repository.dart';
import 'package:usanacaixaapp/ui/views/auth/stores/auth_store.dart';
import 'package:usanacaixaapp/data/http/http_client.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthStore store = AuthStore(
    authRepository: AuthRepository(
      client: HttpClient(),
    ),
  );

  Future<void> login(String email, String password) async {
    try {
      await store.loginUser(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(UserRegisterModel userRegister) async {
    try {
      await store.registerUser(userRegister);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await store.logoutUser();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> initialize() async {
    try {
      await store.getUserInfo();
    } catch (e) {
      rethrow;
    }
  }
}
