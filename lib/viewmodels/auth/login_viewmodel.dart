import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/services/exception_service.dart';
import 'package:usanacaixaapp/viewmodels/base_viewmodel.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel(super.navigatorService, super.authViewModel);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> login(BuildContext context) async {
    setLoading(true);

    try {
      await authViewModel.login(emailController.text, passwordController.text);
      ExceptionService.showSuccessNotification(
          context, "Log in realizado com sucesso!");
    } catch (e) {
      ExceptionService.showErrorNotification(context, e.toString());
      throw Exception('Erro ao fazer login.');
    } finally {
      setLoading(false);
      closeBottomSheet(context);
    }
  }

  void closeBottomSheet(BuildContext context) {
    Navigator.pop(context);
  }
}
