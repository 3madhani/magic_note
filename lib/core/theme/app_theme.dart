// import 'package:flutter/material.dart';

// class AppTheme {
//   // Colors
//   static const Color goldenColor = Color(0xFFf39c12);
//   static const Color goldenLight = Color(0xFFfcd34d);
//   static const Color goldenDark = Color(0xFFd97706);

//   // Light theme colors
//   static const Color lightBackground = Color(0xFFf8faff);
//   static const Color lightSurface = Color(0xFFffffff);
//   static const Color lightPrimary = Color(0xFF1a1d29);

//   // Dark theme colors
//   static const Color darkBackground = Color(0xFF0f0f23);
//   static const Color darkSurface = Color(0xFF1e1e2e);
//   static const Color darkPrimary = Color(0xFFe2e8f0);

//   // Magical gradients
//   static const LinearGradient magicalPurple = LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [Color(0xFF8b5cf6), Color(0xFF7c3aed)],
//   );

//   static const LinearGradient magicalBlue = LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [Color(0xFF3b82f6), Color(0xFF1d4ed8)],
//   );

//   static const LinearGradient magicalPink = LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [Color(0xFFec4899), Color(0xFFbe185d)],
//   );

//   static const LinearGradient golden = LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [Color(0xFFfbbf24), Color(0xFFf59e0b)],
//   );

//   // Note color gradients
//   static const Map<String, LinearGradient> noteColors = {
//     'yellow': LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [Color(0xFFfef3c7), Color(0xFFfde68a)],
//     ),
//     'blue': LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [Color(0xFFdbeafe), Color(0xFFbfdbfe)],
//     ),
//     'green': LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [Color(0xFFd1fae5), Color(0xFFa7f3d0)],
//     ),
//     'purple': LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [Color(0xFFe9d5ff), Color(0xFFddd6fe)],
//     ),
//     'pink': LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [Color(0xFFfce7f3), Color(0xFFfbcfe8)],
//     ),
//     'orange': LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [Color(0xFFfed7aa), Color(0xFFfdba74)],
//     ),
//   };

//   // Dark note colors
//   static const Map<String, LinearGradient> darkNoteColors = {
//     'yellow': LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [Color(0xFF422006), Color(0xFF451a03)],
//     ),
//     'blue': LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [Color(0xFF1e3a8a), Color(0xFF1e40af)],
//     ),
//     'green': LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [Color(0xFF14532d), Color(0xFF166534)],
//     ),
//     'purple': LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [Color(0xFF581c87), Color(0xFF6b21a8)],
//     ),
//     'pink': LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [Color(0xFF831843), Color(0xFF9d174d)],
//     ),
//     'orange': LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [Color(0xFF9a3412), Color(0xFFc2410c)],
//     ),
//   };

//   static ThemeData get darkTheme {
//     return ThemeData(
//       brightness: Brightness.dark,
//       scaffoldBackgroundColor: darkBackground,
//       primaryColor: darkPrimary,
//       fontFamily: "Cairo",
//       textTheme: ThemeData.dark().textTheme.apply(
//         fontFamily: "Cairo",
//         bodyColor: darkPrimary,
//         displayColor: darkPrimary,
//       ),
//       colorScheme: ColorScheme.fromSeed(
//         seedColor: goldenColor,
//         brightness: Brightness.dark,
//         background: darkBackground,
//         surface: darkSurface,
//         primary: darkPrimary,
//       ),
//       cardTheme: CardThemeData(
//         color: darkSurface.withOpacity(0.95),
//         elevation: 0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: goldenColor,
//           foregroundColor: Colors.white,
//           elevation: 8,
//           shadowColor: goldenColor.withOpacity(0.3),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//     );
//   }

//   static ThemeData get lightTheme {
//     return ThemeData(
//       brightness: Brightness.light,
//       scaffoldBackgroundColor: lightBackground,
//       primaryColor: lightPrimary,
//       fontFamily: "Cairo",
//       textTheme: ThemeData.light().textTheme.apply(
//         fontFamily: "Cairo",
//         bodyColor: lightPrimary,
//         displayColor: lightPrimary,
//       ),
//       colorScheme: ColorScheme.fromSeed(
//         seedColor: goldenColor,
//         brightness: Brightness.light,
//         background: lightBackground,
//         surface: lightSurface,
//         primary: lightPrimary,
//       ),
//       cardTheme: CardThemeData(
//         color: lightSurface.withOpacity(0.95),
//         elevation: 0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: goldenColor,
//           foregroundColor: Colors.white,
//           elevation: 8,
//           shadowColor: goldenColor.withOpacity(0.3),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//     );
//   }
// }
