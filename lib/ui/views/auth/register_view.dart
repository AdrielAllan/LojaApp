import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/data/services/navigation_service.dart';
import 'package:usanacaixaapp/data/utils/size_config.dart';
import 'package:usanacaixaapp/ui/widgets/custom_button.dart';
import 'package:usanacaixaapp/ui/widgets/custom_text_form_field.dart';
import 'package:usanacaixaapp/viewmodels/auth/auth_viewmodel.dart';
import 'package:usanacaixaapp/viewmodels/auth/register_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key, required this.goToLogin});

  final VoidCallback goToLogin;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterViewModel(
          context.read<NavigatorService>(), context.read<AuthViewModel>()),
      child: Consumer<RegisterViewModel>(builder: (context, viewModel, child) {
        return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : AppColors.kDarkColor2,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.getProportionateScreenWidth(30),
                      vertical: SizeConfig.getProportionateScreenWidth(30)),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: viewModel.formKey,
                          child: Column(
                            children: [
                              CustomTextFormField(
                                enable: !viewModel.isLoading,
                                fieldName: "Nome Completo",
                                preffixIcon:
                                    Icon(Icons.person_outline_outlined),
                                width: 1,
                                isFixedWidth: false,
                                controller: viewModel.nameController,
                                hintText: 'Nome Completo',
                                isRequired: true,
                                inputType: TextInputType.text,
                              ),
                              const SizedBox(height: 25),
                              CustomTextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira o número de celular.';
                                  }
                                  final regex = RegExp(r'^\d{11}$');
                                  final formattedValue = value.replaceAll(
                                      RegExp(r'\D'),
                                      ''); // Remove caracteres não numéricos
                                  if (!regex.hasMatch(formattedValue)) {
                                    return 'Insira um número de celular válido.';
                                  }
                                  return null;
                                },
                                enable: !viewModel.isLoading,
                                maskFormatter:
                                    MaskedInputFormatter("(00)0 0000-0000"),
                                fieldName: "Celular",
                                preffixIcon: Icon(Icons.phone_android_outlined),
                                width: 1,
                                isFixedWidth: false,
                                controller: viewModel.phoeNumerController,
                                hintText: '(99)9 9999-9999',
                                isRequired: true,
                                inputType: TextInputType.phone,
                              ),
                              const SizedBox(height: 25),
                              CustomTextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira o CPF.';
                                  }

                                  final regex = RegExp(r'^\d{11}$');
                                  final formattedValue = value.replaceAll(
                                      RegExp(r'\D'),
                                      ''); // Remove caracteres não numéricos
                                  if (!regex.hasMatch(formattedValue)) {
                                    return 'CPF inválido. Deve conter 11 números.';
                                  }

                                  if (!viewModel.isValidCPF(formattedValue)) {
                                    return 'CPF inválido.';
                                  }
                                  return null;
                                },
                                enable: !viewModel.isLoading,
                                fieldName: "CPF",
                                maskFormatter:
                                    MaskedInputFormatter('000.000.000-00'),
                                preffixIcon: Icon(Icons.co_present_outlined),
                                width: 1,
                                isFixedWidth: false,
                                controller: viewModel.cpfController,
                                hintText: '999.999.999-99',
                                isRequired: true,
                                inputType: TextInputType.number,
                              ),
                              const SizedBox(height: 25),
                              CustomTextFormField(
                                enable: !viewModel.isLoading,
                                preffixIcon:
                                    Icon(Icons.alternate_email_rounded),
                                fieldName: "Email",
                                isEmailField: true,
                                width: 1,
                                isFixedWidth: false,
                                controller: viewModel.emailController,
                                hintText: 'info@example.com',
                                isRequired: true,
                                inputType: TextInputType.text,
                              ),
                              const SizedBox(height: 25),
                              CustomTextFormField(
                                enable: !viewModel.isLoading,
                                fieldName: "Senha",
                                preffixIcon: Icon(Icons.lock_outline_rounded),
                                isPasswordField: true,
                                width: 1,
                                isFixedWidth: false,
                                controller: viewModel.passwordController,
                                hintText: 'Senha',
                                isRequired: true,
                                inputType: TextInputType.text,
                              ),
                              const SizedBox(height: 25),
                              CustomTextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, confirme sua senha.';
                                  }
                                  if (value !=
                                      viewModel.passwordController.text) {
                                    return 'As senhas não coincidem.';
                                  }
                                  return null;
                                },
                                enable: !viewModel.isLoading,
                                fieldName: "Confirmar Senha",
                                preffixIcon: Icon(Icons.lock_outline_rounded),
                                isPasswordField: true,
                                width: 1,
                                isFixedWidth: false,
                                controller: viewModel.rePasswordController,
                                hintText: 'Senha',
                                isRequired: true,
                                inputType: TextInputType.text,
                              ),
                              const SizedBox(height: 32),
                              CustomButton(
                                isLoading: viewModel.isLoading,
                                text: "Registrar",
                                isFixedWidth: false,
                                onPressed: () {
                                  if (viewModel.formKey.currentState!
                                      .validate()) {
                                    viewModel.register(context);
                                  }
                                },
                                width: 1,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: InkWell(
                  onTap: widget.goToLogin,
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
