import 'package:flutter/material.dart';

class AppColors {
  static const kPrimaryColor = Color(0xFFFF222A);
  static const kPrimaryColor2 = Color(0xFF010B9E);
  static const kPrimaryLightColor = Color(0xFFFFECDF);
  static const kPrimaryGradientColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      kPrimaryColor2,
      kPrimaryColor,
    ],
  );

  static const kGradientVerticalColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      kPrimaryColor,
      kPrimaryColor2,
    ],
  );

  static const kDarkColor1 = Color(0xFF0C153B);
  static const kDarkColor2 = Color(0xFF1C2244);
  static const kSecondaryColor = Color(0xFF979797);
  static const kTextColor = Color(0xFF757575);

  static const kAnimationDuration = Duration(milliseconds: 200);
}
