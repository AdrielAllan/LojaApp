import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/theme/app_theme.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.press,
  });

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: isLightTheme
                ? Colors.grey[350]!
                : AppTheme.darkTheme.scaffoldBackgroundColor,
            width: 2,
          ),
        ),
        child: Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
              color: isLightTheme
                  ? Colors.grey[350]!
                  : AppTheme.darkTheme.scaffoldBackgroundColor,
              shape: BoxShape.circle),
          child: Icon(Icons.menu),
        ),
      ),
    );
  }
}
