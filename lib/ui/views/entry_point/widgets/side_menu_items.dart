import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:usanacaixaapp/data/models/rive_asset.dart';

class SideMenuItems extends StatelessWidget {
  const SideMenuItems({
    super.key,
    required this.press,
    required this.riverInit,
    required this.isActive,
    required this.menu,
  });

  final RiveAsset menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riverInit;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              height: 56,
              width: isActive ? 288 : 0,
              left: 0,
              child: Container(
                  decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: RiveAnimation.asset(
                  menu.src,
                  artboard: menu.artboard,
                  onInit: riverInit,
                ),
              ),
              title: Text(
                menu.title,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
