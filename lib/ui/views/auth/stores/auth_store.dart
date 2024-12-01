import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/models/user_model.dart';
import 'package:usanacaixaapp/data/models/user_register_model.dart';
import 'package:usanacaixaapp/data/repositories/auth_repository.dart';
import 'package:usanacaixaapp/data/services/auth_service_token_storage.dart';

class AuthStore {
  final IAuthRepository authRepository;
  final AuthServiceTokenStorage authService = AuthServiceTokenStorage();

  final ValueNotifier<String?> token = ValueNotifier<String?>("");
  final ValueNotifier<UserModel?> user = ValueNotifier<UserModel?>(null);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String> errorMessage = ValueNotifier<String>("");

  AuthStore({required this.authRepository});

  Future<void> registerUser(UserRegisterModel userRegister) async {
    isLoading.value = true;

    try {
      token.value = await authRepository.registerUser(userRegister);
      if (token.value != null) {
        authService.saveToken(token.value!);
      }
      await getUserInfo();
    } catch (error) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginUser(String email, String password) async {
    isLoading.value = true;

    try {
      await authService.clearToken();
      token.value = await authRepository.loginUser(email, password);
      if (token.value != null) {
        await authService.saveToken(token.value!);
      }
      await getUserInfo();
    } catch (error) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logoutUser() async {
    isLoading.value = true;

    try {
      await authService.clearToken();
      token.value = "";
      user.value = null;
    } catch (error) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getUserInfo() async {
    isLoading.value = true;

    try {
      await getToken();
      if (token.value != null && token.value != "") {
        user.value = await authRepository.getUserInfo(token.value!);
      }
    } catch (error) {
      errorMessage.value = error.toString();
      authService.clearToken();
      user.value = null;
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkSession() async {
    try {
      if (token.value != null) {
        await authRepository.checkSession(token.value!);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getToken() async {
    isLoading.value = true;

    try {
      token.value = await authService.getToken();
    } catch (error) {
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
