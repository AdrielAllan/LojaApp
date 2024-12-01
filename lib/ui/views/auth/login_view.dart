import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/data/services/navigation_service.dart';
import 'package:usanacaixaapp/data/utils/size_config.dart';
import 'package:usanacaixaapp/ui/views/auth/register_view.dart';
import 'package:usanacaixaapp/ui/widgets/custom_button.dart';
import 'package:usanacaixaapp/ui/widgets/custom_text_form_field.dart';
import 'package:usanacaixaapp/viewmodels/auth/auth_viewmodel.dart';
import 'package:usanacaixaapp/viewmodels/auth/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.goToRegister});

  final VoidCallback goToRegister;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(
          context.read<NavigatorService>(), context.read<AuthViewModel>()),
      child: Consumer<LoginViewModel>(builder: (context, viewModel, child) {
        return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : AppColors.kDarkColor2,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.getProportionateScreenWidth(30)),
                    child: Form(
                      key: viewModel.formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            enable: !viewModel.isLoading,
                            preffixIcon: Icon(Icons.alternate_email_rounded),
                            fieldName: "Email",
                            isEmailField: true,
                            width: 1,
                            isFixedWidth: false,
                            controller: viewModel.emailController,
                            hintText: 'info@example.com',
                            isRequired: true,
                            inputType: TextInputType.text,
                          ),
                          const SizedBox(height: 16),
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
                          const SizedBox(height: 32),
                          CustomButton(
                            isLoading: viewModel.isLoading,
                            text: "Entrar",
                            isFixedWidth: false,
                            onPressed: () {
                              if (viewModel.formKey.currentState!.validate()) {
                                viewModel.login(context);
                              }
                            },
                            width: 1,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: RichText(
                                  maxLines: 2,
                                  text: TextSpan(
                                    text: "Ainda não tem uma conta? ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white),
                                    children: [
                                      TextSpan(
                                        text: "Cadastra-se Agora",
                                        style: TextStyle(
                                          color: AppColors
                                              .kPrimaryColor, // Cor do texto clicável
                                          fontWeight: FontWeight.bold,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = widget.goToRegister,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(100)),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: InkWell(
                      child: Icon(Icons.close),
                      onTap: () {
                        viewModel.closeBottomSheet(context); // Fecha o modal
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

Future<void> onShowBottomSheetLogin(
    BuildContext context, VoidCallback? function) async {
  final PageController pageController = PageController();
  void goToRegister() {
    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void goToLogin() {
    pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return FractionallySizedBox(
          heightFactor: 0.95, // O modal ocupará 95% da altura da tela
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              LoginView(
                goToRegister: goToRegister,
              ),
              RegisterView(
                goToLogin: goToLogin,
              )
            ],
          ));
    },
  );

  if (context.mounted) {
    final authViewModel = context.read<AuthViewModel>();
    if (authViewModel.store.user.value != null && function != null) {
      function();
    }
  }
}
