import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usanacaixaapp/ui/views/entry_point/widgets/avatar_icon.dart';
import 'package:usanacaixaapp/ui/views/entry_point/widgets/menu_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.buttonMenuPress,
  });

  final VoidCallback buttonMenuPress;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: SvgPicture.asset(
          'assets/images/logo.svg',
          width: 35,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Row(
            children: [
              //AvatarIcon(),
              SizedBox(
                width: 10,
              ),
              MenuButton(
                press: buttonMenuPress,
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
