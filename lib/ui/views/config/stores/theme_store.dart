import 'package:flutter/material.dart';

class ThemeStore {
  final ValueNotifier<ThemeMode> themeMode = ValueNotifier<ThemeMode>(ThemeMode.light);

  void setThemeMode(ThemeMode mode) {
    themeMode.value = mode;
  }
}

final themeStore = ThemeStore();
