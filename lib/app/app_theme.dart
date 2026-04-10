import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData _lightThemeData = ThemeData.light();
  static ThemeData _darkThemeData = ThemeData.dark();

  static ThemeData get lightTheme => _lightThemeData;
  static ThemeData get darkTheme => _darkThemeData;
}