import 'package:flutter/material.dart';
import '../constants/color_constants.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.kPrimaryColor,
      colorScheme: const ColorScheme.light(
        primary: AppColors.kPrimaryColor,
        secondary: AppColors.kSecondaryColor,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Colors.black),
      ));

  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xFF0C153B),
      cardTheme: const CardTheme(
        color: Color(0xFF242644),
      ),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1C2244)),
      brightness: Brightness.dark,
      primaryColor: AppColors.kPrimaryColor,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.kPrimaryColor,
        secondary: AppColors.kSecondaryColor,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Colors.white),
        displayMedium: TextStyle(color: Colors.white),
      ));
}
