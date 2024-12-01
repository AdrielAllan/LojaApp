import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:usanacaixaapp/data/models/rive_asset.dart';
import 'package:usanacaixaapp/data/utils/rive_utils.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: sideMenus
          .map(
            (menu) => BottomNavigationBarItem(
                icon: SizedBox(
                  height: 40,
                  child: RiveAnimation.asset(
                    menu.src,
                    artboard: menu.artboard,
                    onInit: (artboard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(artboard,
                              stateMachineName: menu.stateMachineName);
                      menu.input = controller.findSMI("active") as SMIBool;
                    },
                  ),
                ),
                label: menu.title),
          )
          .toList(),
    );
  }
}


/*const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Configurações'),
      ], */