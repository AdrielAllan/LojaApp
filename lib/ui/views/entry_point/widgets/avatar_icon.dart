import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/theme/app_theme.dart';

class AvatarIcon extends StatelessWidget {
  const AvatarIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return Container(
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
      child: CircleAvatar(
        radius: 18,
        backgroundColor: isLightTheme
            ? Colors.grey[350]!
            : AppTheme.darkTheme.scaffoldBackgroundColor,
        child: Icon(
          Icons.person,
          color: isLightTheme ? Colors.black : Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
