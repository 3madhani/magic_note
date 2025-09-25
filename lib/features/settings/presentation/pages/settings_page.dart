import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/theme_constants.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/magical_text.dart';
import '../../../app/cubit/app_cubit.dart';
import '../../../app/cubit/app_state.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(child: _buildSettingsContent(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutOption(String title, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Text(
          value,
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildActionOption(String title, IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title feature coming soon!'),
            backgroundColor: ThemeConstants.goldenColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Row(
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.8)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white.withOpacity(0.5),
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildDataOption(String title, IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title feature coming soon!'),
            backgroundColor: ThemeConstants.goldenColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Row(
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.8)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white.withOpacity(0.5),
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          GlassContainer(
            padding: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(12),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () =>
                  context.read<AppCubit>().navigateToScreen(AppScreen.home),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: MagicalText(
              text: 'Settings',
              gradientColors: [
                Color(0xFFfbbf24),
                Color(0xFFf59e0b),
                Color(0xFFfbbf24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Row(
      children: [
        Icon(Icons.language, color: Colors.white.withOpacity(0.8)),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'Language',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: const Text(
            'English',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () => _showLogoutDialog(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          shadowColor: Colors.red.withOpacity(0.3),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: Colors.white),
            SizedBox(width: 12),
            Text(
              'Sign Out',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: ThemeConstants.goldenColor, size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children.map(
            (child) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsContent(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is SettingsUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: ThemeConstants.goldenColor,
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
            _buildSection(
              context: context,
              title: 'Appearance',
              icon: Icons.palette_outlined,
              children: [
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    bool isDarkMode = false;
                    if (state is SettingsLoaded) {
                      isDarkMode = state.settings.isDarkMode;
                    }

                    return _buildThemeToggle(context, isDarkMode);
                  },
                ),
                _buildLanguageSelector(),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              context: context,
              title: 'Data & Privacy',
              icon: Icons.security_outlined,
              children: [
                _buildDataOption(
                  'Export Notes',
                  Icons.download_outlined,
                  context,
                ),
                _buildDataOption(
                  'Import Notes',
                  Icons.upload_outlined,
                  context,
                ),
                _buildDataOption(
                  'Backup to Cloud',
                  Icons.cloud_upload_outlined,
                  context,
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              context: context,
              title: 'About',
              icon: Icons.info_outlined,
              children: [
                _buildAboutOption('Version', AppConstants.appVersion),
                _buildAboutOption('Developer', AppConstants.developer),
                _buildActionOption('Rate App', Icons.star_outline, context),
                _buildActionOption(
                  'Send Feedback',
                  Icons.feedback_outlined,
                  context,
                ),
              ],
            ),
            const SizedBox(height: 40),
            _buildLogoutButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context, bool isDarkMode) {
    return Row(
      children: [
        Icon(
          isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'Dark Mode',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Switch(
          value: isDarkMode,
          onChanged: (_) => context.read<SettingsCubit>().toggleDarkMode(),
          activeThumbColor: ThemeConstants.goldenColor,
          activeTrackColor: ThemeConstants.goldenColor.withOpacity(0.3),
          inactiveThumbColor: Colors.white.withOpacity(0.8),
          inactiveTrackColor: Colors.white.withOpacity(0.2),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Sign Out',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        content: const Text(
          'Are you sure you want to sign out? Your notes will be saved locally.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white.withOpacity(0.8)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AuthCubit>().logout();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('You have been signed out. See you soon!'),
                  backgroundColor: ThemeConstants.goldenColor,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Sign Out',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
