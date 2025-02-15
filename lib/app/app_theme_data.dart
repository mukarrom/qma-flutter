import 'package:flutter/material.dart';
import 'package:qma/app/app_colors.dart';

class AppThemeData {
  static ThemeData get lightThemeData {
    return ThemeData(
      colorSchemeSeed: AppColors.themeColor,
      fontFamily: 'Ador',
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
        labelStyle: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
    );
  }

  static ThemeData get darkThemeData {
    return ThemeData(
      colorSchemeSeed: AppColors.themeColor,
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        hintStyle: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}
