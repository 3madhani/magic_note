import 'package:flutter/material.dart';

import '../constants/theme_constants.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ThemeConstants.darkBackground,
      primaryColor: ThemeConstants.darkPrimary,
      fontFamily: "Cairo",
      textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: "Cairo",
        bodyColor: ThemeConstants.darkPrimary,
        displayColor: ThemeConstants.darkPrimary,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: ThemeConstants.goldenColor,
        brightness: Brightness.dark,
        background: ThemeConstants.darkBackground,
        surface: ThemeConstants.darkSurface,
        primary: ThemeConstants.darkPrimary,
      ),
      cardTheme: CardThemeData(
        color: ThemeConstants.darkSurface.withOpacity(0.95),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeConstants.goldenColor,
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: ThemeConstants.goldenColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: ThemeConstants.lightBackground,
      primaryColor: ThemeConstants.lightPrimary,
      fontFamily: "Cairo",
      textTheme: ThemeData.light().textTheme.apply(
        fontFamily: "Cairo",
        bodyColor: ThemeConstants.lightPrimary,
        displayColor: ThemeConstants.lightPrimary,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: ThemeConstants.goldenColor,
        brightness: Brightness.light,
        background: ThemeConstants.lightBackground,
        surface: ThemeConstants.lightSurface,
        primary: ThemeConstants.lightPrimary,
      ),
      cardTheme: CardThemeData(
        color: ThemeConstants.lightSurface.withOpacity(0.95),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeConstants.goldenColor,
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: ThemeConstants.goldenColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
