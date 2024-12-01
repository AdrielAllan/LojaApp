import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/models/user_register_model.dart';
import 'package:usanacaixaapp/data/services/exception_service.dart';
import 'package:usanacaixaapp/viewmodels/base_viewmodel.dart';

class RegisterViewModel extends BaseViewModel {
  RegisterViewModel(super.navigatorService, super.authViewModel);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoeNumerController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> register(BuildContext context) async {
    setLoading(true);

    try {
      final userRegister = UserRegisterModel(
          name: nameController.text,
          phoneNumber: phoeNumerController.text,
          cpf: cpfController.text,
          email: emailController.text,
          password: passwordController.text,
          rePassword: rePasswordController.text);

      await authViewModel.register(userRegister);
      ExceptionService.showSuccessNotification(
          context, "Cadastro realizado com sucesso!");
    } catch (e) {
      ExceptionService.showErrorNotification(context, e.toString());
      throw ('Erro ao registrar.');
    } finally {
      setLoading(false);
      closeBottomSheet(context);
    }
  }

  bool isValidCPF(String cpf) {
    // Verifica se o CPF tem 11 dígitos e não é uma sequência repetida
    if (cpf.length != 11 || RegExp(r'^(\d)\1*$').hasMatch(cpf)) {
      return false;
    }

    // Calcula os dígitos verificadores
    final List<int> numbers = cpf.split('').map(int.parse).toList();

    for (int j = 9; j < 11; j++) {
      int sum = 0;
      for (int i = 0; i < j; i++) {
        sum += numbers[i] * ((j + 1) - i);
      }
      int digit = (sum * 10) % 11;
      if (digit == 10) digit = 0;
      if (digit != numbers[j]) {
        return false;
      }
    }
    return true;
  }

  void closeBottomSheet(BuildContext context) {
    Navigator.pop(context);
  }
}
