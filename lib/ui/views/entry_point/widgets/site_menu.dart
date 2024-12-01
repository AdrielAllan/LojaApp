import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/data/models/rive_asset.dart';
import 'package:usanacaixaapp/data/utils/rive_utils.dart';
import 'package:usanacaixaapp/ui/views/entry_point/widgets/info_profile_menu.dart';
import 'package:usanacaixaapp/ui/views/entry_point/widgets/side_menu_items.dart';
import 'package:usanacaixaapp/viewmodels/auth/auth_viewmodel.dart';

class SideMenu extends StatefulWidget {
  const SideMenu(
      {super.key, required this.press, required this.onMenuItemSelected});

  final VoidCallback press;
  final Function(int) onMenuItemSelected;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sideMenus.first;
  @override
  Widget build(BuildContext context) {
    final authViewModel = context.read<AuthViewModel>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: widget.press,
            child: Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Stack(
            children: [
              Container(
                width: 288,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: AppColors.kPrimaryGradientColor,
                ),
                height: double.infinity,
                child: SafeArea(
                  child: AnimatedBuilder(
                      animation: Listenable.merge([
                        authViewModel.store.isLoading,
                        authViewModel.store.errorMessage,
                        authViewModel.store.user
                      ]),
                      builder: (context, child) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            authViewModel.store.user.value != null
                                ? InfoPofileMenu(
                                    user: authViewModel.store.user.value!,
                                  )
                                : SizedBox.shrink(),
                            SizedBox(
                              height: 30,
                            ),
                            ...sideMenus.map(
                              (menu) => SideMenuItems(
                                menu: menu,
                                riverInit: (artboard) {
                                  StateMachineController controller =
                                      RiveUtils.getRiveController(artboard,
                                          stateMachineName:
                                              menu.stateMachineName);
                                  menu.input =
                                      controller.findSMI("active") as SMIBool;
                                },
                                press: () {
                                  menu.input!.change(true);
                                  Future.delayed(Duration(seconds: 1), () {
                                    menu.input!.change(false);
                                  });
                                  setState(() {
                                    widget.onMenuItemSelected(menu.id);
                                    selectedMenu = menu;
                                  });
                                },
                                isActive: selectedMenu == menu,
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
              Positioned(
                top: 30,
                right: 10,
                child: InkWell(
                    onTap: widget.press,
                    child: Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
