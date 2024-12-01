import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/data/services/navigation_service.dart';
import 'package:usanacaixaapp/ui/views/config/stores/theme_store.dart';
import 'package:usanacaixaapp/ui/widgets/custom_app_bar.dart';
import 'package:usanacaixaapp/viewmodels/auth/auth_viewmodel.dart';
import 'package:usanacaixaapp/viewmodels/config/config_viewmodel.dart';

class ConfigView extends StatefulWidget {
  const ConfigView(
      {super.key, required this.buttonMenuPress, required this.goBackHome});

  final VoidCallback buttonMenuPress;
  final VoidCallback goBackHome;

  @override
  State<ConfigView> createState() => _ConfigViewState();
}

class _ConfigViewState extends State<ConfigView> {
  bool isDarkMode = false;

  final ThemeStore store = ThemeStore();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConfigViewModel(
        context.read<NavigatorService>(),
        context.read<AuthViewModel>(),
        goBackHome: widget.goBackHome,
      ),
      child: Consumer<ConfigViewModel>(builder: (context, viewModel, child) {
        return AnimatedBuilder(
            animation: Listenable.merge(
                [themeStore.themeMode, viewModel.authViewModel.store.user]),
            builder: (context, child) {
              return Scaffold(
                appBar: CustomAppBar(buttonMenuPress: widget.buttonMenuPress),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        ListTile(
                          title: const Text("Modo escuro"),
                          trailing: Switch(
                            value: themeStore.themeMode.value == ThemeMode.dark,
                            onChanged: (value) {
                              themeStore.setThemeMode(
                                  value ? ThemeMode.dark : ThemeMode.light);
                            },
                          ),
                        ),
                        viewModel.authViewModel.store.user.value != null
                            ? GestureDetector(
                                onTap: () {
                                  viewModel.logOutUser();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black.withOpacity(0.1)
                                        : Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.logout,
                                          color: AppColors.kPrimaryColor,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        const Text("Log out"),
                                      ],
                                    ),
                                    trailing:
                                        Icon(Icons.arrow_forward_ios_rounded),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }
}
