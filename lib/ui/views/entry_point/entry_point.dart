import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/data/models/rive_asset.dart';
import 'package:usanacaixaapp/ui/views/cart/group_cart_view.dart';
import 'package:usanacaixaapp/ui/views/config/config_view.dart';
import 'package:usanacaixaapp/ui/views/entry_point/widgets/site_menu.dart';
import 'package:usanacaixaapp/ui/views/home/home_view.dart';
import 'package:usanacaixaapp/ui/views/orders/orders_view.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  bool isSideMenuClosed = true; // Controle de abertura do SideMenu
  Icon selectedBottomNav =
      bottomNavBar.first; // Ícone selecionado no BottomNavBar
  int currentIndex = 0; // Índice da tela atual

  // Função para alternar o estado do SideMenu
  void toggleMenu() {
    setState(() {
      isSideMenuClosed = !isSideMenuClosed;
    });
  }

  // Função para navegar entre telas
  void navigateTo(int index) {
    setState(() {
      currentIndex = index;
      selectedBottomNav = bottomNavBar[index];
      isSideMenuClosed = true; // Fecha o SideMenu ao navegar
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeView(
        buttonMenuPress: toggleMenu,
      ),
      GroupCartView(
        buttonMenuPress: toggleMenu,
      ),
      OrderView(
        buttonMenuPress: toggleMenu,
      ),
      ConfigView(
        buttonMenuPress: toggleMenu,
        goBackHome: () {
          navigateTo(0); // Navegar de volta para Home
        },
      ),
    ];

    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: customNavBar(context),
      ),
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          screens[currentIndex], // Mostra a tela atual
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            width: MediaQuery.of(context).size.width,
            left: isSideMenuClosed ? -MediaQuery.of(context).size.width : 0,
            height: MediaQuery.of(context).size.height,
            child: SideMenu(
              press: toggleMenu,
              onMenuItemSelected: (index) {
                navigateTo(index); // Navegar e sincronizar estado
              },
            ),
          ),
        ],
      ),
    );
  }

  Transform customNavBar(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, isSideMenuClosed ? 0 : 100),
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.kDarkColor1.withOpacity(0.8)
              : AppColors.kDarkColor2.withOpacity(0.8),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...List.generate(
              bottomNavBar.length,
              (index) => GestureDetector(
                onTap: () {
                  if (bottomNavBar[index] != selectedBottomNav) {
                    navigateTo(index); // Sincroniza navegação
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 2),
                      height: 4,
                      width: bottomNavBar[index] == selectedBottomNav ? 20 : 0,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: Opacity(
                        opacity:
                            bottomNavBar[index] == selectedBottomNav ? 1 : 0.5,
                        child: bottomNavBar[index],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
