import 'package:flutter/material.dart';
import '../enums/app_theme_enum.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

class AppTheme {
  static ThemeData getThemeFromKey(ThemeKey key) {
    switch (key) {
      case ThemeKey.light:
        return lightTheme;
      case ThemeKey.dark:
        return darkTheme;
      default:
        return lightTheme;
    }
  }
}
