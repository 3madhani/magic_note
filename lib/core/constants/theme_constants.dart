import 'package:flutter/material.dart';

class ThemeConstants {
  // Colors
  static const Color goldenColor = Color(0xFFf39c12);
  static const Color goldenLight = Color(0xFFfcd34d);
  static const Color goldenDark = Color(0xFFd97706);

  // Light theme colors
  static const Color lightBackground = Color(0xFFf8faff);
  static const Color lightSurface = Color(0xFFffffff);
  static const Color lightPrimary = Color(0xFF1a1d29);

  // Dark theme colors
  static const Color darkBackground = Color(0xFF0f0f23);
  static const Color darkSurface = Color(0xFF1e1e2e);
  static const Color darkPrimary = Color(0xFFe2e8f0);

  // Magical gradients
  static const LinearGradient magicalPurple = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8b5cf6), Color(0xFF7c3aed)],
  );

  static const LinearGradient magicalBlue = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3b82f6), Color(0xFF1d4ed8)],
  );

  static const LinearGradient magicalPink = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFec4899), Color(0xFFbe185d)],
  );

  static const LinearGradient golden = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFfbbf24), Color(0xFFf59e0b)],
  );

  // Note color gradients for light theme
  static const Map<String, LinearGradient> noteColors = {
    'babyblue': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromARGB(255, 135, 206, 250),
        Color.fromARGB(255, 173, 216, 230),
      ],
    ),
    'yellow': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ThemeConstants.goldenLight, ThemeConstants.goldenColor],
    ),
    'blue': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFdbeafe), Color(0xFFbfdbfe)],
    ),
    'green': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFd1fae5), Color(0xFFa7f3d0)],
    ),
    'purple': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFe9d5ff), Color(0xFFddd6fe)],
    ),
    'pink': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFfce7f3), Color(0xFFfbcfe8)],
    ),
    'orange': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFfed7aa), Color(0xFFfdba74)],
    ),
  };

  // Note color gradients for dark theme
  static const Map<String, LinearGradient> darkNoteColors = {
    'babyblue': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromARGB(255, 100, 149, 237),
        Color.fromARGB(255, 70, 130, 180),
      ],
    ),

    'yellow': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ThemeConstants.goldenColor, ThemeConstants.goldenDark],
    ),
    'blue': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF1e40af), Color(0xFF1e3a8a)],
    ),
    'green': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF166534), Color(0xFF14532d)],
    ),
    'purple': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF6b21a8), Color(0xFF581c87)],
    ),
    'pink': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF9d174d), Color(0xFF831843)],
    ),
    'orange': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFc2410c), Color(0xFF9a3412)],
    ),
  };
}
