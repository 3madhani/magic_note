import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/cubit/app_cubit.dart';
import '../../../app/cubit/app_state.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import '../widgets/settings_header.dart';
import '../widgets/settings_language_selector.dart';
import '../widgets/settings_logout_button.dart';
import '../widgets/settings_option.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_theme_toggle.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(
              onBack: () {
                context.read<AppCubit>().navigateToScreen(AppScreen.home);
              },
            ),
            Expanded(child: _buildSettingsContent(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is SettingsUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: colorScheme.secondary,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SettingsSection(
              title: 'Appearance',
              icon: Icons.palette_outlined,
              children: [
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    bool isDarkMode =
                        state is SettingsLoaded && state.settings.isDarkMode;
                    return SettingsThemeToggle(isDarkMode: isDarkMode);
                  },
                ),
                const SettingsLanguageSelector(),
              ],
            ),
            const SizedBox(height: 24),
            SettingsSection(
              title: 'Data & Privacy',
              icon: Icons.security_outlined,
              children: const [
                SettingsOption(
                  title: 'Export Notes',
                  icon: Icons.download_outlined,
                ),
                SettingsOption(
                  title: 'Import Notes',
                  icon: Icons.upload_outlined,
                ),
                SettingsOption(
                  title: 'Backup to Cloud',
                  icon: Icons.cloud_upload_outlined,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingsSection(
              title: 'About',
              icon: Icons.info_outlined,
              children: const [
                SettingsOption(title: 'Version', value: '1.0.0'),
                SettingsOption(title: 'Developer', value: 'Your Name'),
                SettingsOption(title: 'Rate App', icon: Icons.star_outline),
                SettingsOption(
                  title: 'Send Feedback',
                  icon: Icons.feedback_outlined,
                ),
              ],
            ),
            const SizedBox(height: 40),
            const SettingsLogoutButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
