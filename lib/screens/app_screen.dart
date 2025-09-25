// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/app_provider.dart';
// import 'auth_screen.dart';
// import 'home_screen.dart';
// import 'note_editor_screen.dart';
// import 'settings_screen.dart';
// import '../core/widgets/reminder_modal.dart';

// class AppScreen extends StatelessWidget {
//   const AppScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AppProvider>(
//       builder: (context, provider, child) {
//         return Scaffold(
//           body: Stack(
//             children: [
//               // Background gradient
//               Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: provider.isDarkMode
//                         ? [
//                             const Color(0xFF0f0f23),
//                             const Color(0xFF1a1a2e),
//                           ]
//                         : [
//                             const Color(0xFF667eea),
//                             const Color(0xFF764ba2),
//                           ],
//                   ),
//                 ),
//               ),
//               // Main content
//               _buildCurrentScreen(provider),
//               // Reminder modal
//               if (provider.isReminderModalOpen)
//                 const ReminderModal(),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildCurrentScreen(AppProvider provider) {
//     if (!provider.isAuthenticated) {
//       return const AuthScreen();
//     }

//     switch (provider.currentScreen) {
//       case AppScreenEnum.home:
//         return const HomeScreen();
//       case AppScreenEnum.editor:
//         return const NoteEditorScreen();
//       case AppScreenEnum.settings:
//         return const SettingsScreen();
//       default:
//         return const HomeScreen();
//     }
//   }
// }