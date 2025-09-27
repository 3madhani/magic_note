import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/reminder_modal.dart';
import '../../auth/presentation/cubit/auth_cubit.dart';
import '../../auth/presentation/cubit/auth_state.dart';
import '../../auth/presentation/pages/auth_page.dart';
import '../../notes/presentation/pages/create_note_page.dart';
import '../../notes/presentation/pages/home_page.dart';
import '../../settings/presentation/pages/settings_page.dart';
import '../cubit/app_cubit.dart';
import '../cubit/app_state.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        if (authState is AuthAuthenticated) {
          return BlocBuilder<AppCubit, AppState>(
            builder: (context, appState) {
              return Scaffold(
                body: Stack(
                  children: [
                    // Background gradient

                    // Main content
                    _buildCurrentScreen(appState.currentScreen),
                    // Reminder modal
                    if (appState.isReminderModalOpen) const ReminderModal(),
                  ],
                ),
              );
            },
          );
        }

        return const AuthPage();
      },
    );
  }

  Widget _buildCurrentScreen(AppScreen screen) {
    switch (screen) {
      case AppScreen.home:
        return const HomePage();
      case AppScreen.create:
        return const CreateNotePage();

      case AppScreen.settings:
        return const SettingsPage();
      default:
        return const HomePage();
    }
  }
}
