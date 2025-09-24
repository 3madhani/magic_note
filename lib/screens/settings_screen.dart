import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/magical_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                // Header
                _buildHeader(provider),

                // Settings content
                Expanded(child: _buildSettingsContent(provider, context)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAboutOption(String title, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
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
            content: Text('$title feature coming soon! ✨'),
            backgroundColor: AppTheme.goldenColor,
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
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
              ),
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
            content: Text('$title feature coming soon! ✨'),
            backgroundColor: AppTheme.goldenColor,
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
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
              ),
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

  Widget _buildHeader(AppProvider provider) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          // Back button
          GlassContainer(
                padding: const EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(12),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => provider.navigateToHome(),
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms)
              .slideX(begin: -0.3, duration: 400.ms),

          const SizedBox(width: 16),

          // Title
          const Expanded(
                child: MagicalText(
                  text: '⚙️ Settings',
                  gradientColors: [
                    Color(0xFFfbbf24),
                    Color(0xFFf59e0b),
                    Color(0xFFfbbf24),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms, delay: 100.ms)
              .slideX(begin: -0.3, duration: 400.ms),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Row(
      children: [
        Icon(Icons.language, color: Colors.white.withOpacity(0.8)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Language',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Text(
            'English',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(AppProvider provider, BuildContext context) {
    return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () => _showLogoutDialog(provider, context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              shadowColor: Colors.red.withOpacity(0.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout, color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  'Sign Out',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: 800.ms)
        .slideY(begin: 0.3, duration: 600.ms);
  }

  Widget _buildNotificationToggle(String title, bool initialValue) {
    return _NotificationToggle(title: title, initialValue: initialValue);
  }

  Widget _buildSection({
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
              Icon(icon, color: AppTheme.goldenColor, size: 24),
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
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, duration: 600.ms);
  }

  Widget _buildSettingsContent(AppProvider provider, BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Appearance section
          _buildSection(
            title: 'Appearance',
            icon: Icons.palette_outlined,
            children: [
              _buildThemeToggle(provider, context),
              _buildLanguageSelector(),
            ],
          ),

          const SizedBox(height: 24),

          // Notifications section
          _buildSection(
            title: 'Notifications',
            icon: Icons.notifications_outlined,
            children: [
              _buildNotificationToggle('Push Notifications', true),
              _buildNotificationToggle('Reminder Alerts', true),
              _buildNotificationToggle('Weekly Summary', false),
            ],
          ),

          const SizedBox(height: 24),

          // Data section
          _buildSection(
            title: 'Data & Privacy',
            icon: Icons.security_outlined,
            children: [
              _buildDataOption(
                'Export Notes',
                Icons.download_outlined,
                context,
              ),
              _buildDataOption('Import Notes', Icons.upload_outlined, context),
              _buildDataOption(
                'Backup to Cloud',
                Icons.cloud_upload_outlined,
                context,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // About section
          _buildSection(
            title: 'About',
            icon: Icons.info_outlined,
            children: [
              _buildAboutOption('Version', '1.0.0'),
              _buildAboutOption('Developer', 'Magic Notes Team'),
              _buildActionOption('Rate App', Icons.star_outline, context),
              _buildActionOption(
                'Send Feedback',
                Icons.feedback_outlined,
                context,
              ),
            ],
          ),

          const SizedBox(height: 40),

          // Logout button
          _buildLogoutButton(provider, context),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildThemeToggle(AppProvider provider, BuildContext context) {
    return Row(
      children: [
        Icon(
          provider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Dark Mode',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ),
        Switch(
          value: provider.isDarkMode,
          onChanged: (_) {
            provider.toggleTheme();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Switched to ${provider.isDarkMode ? 'light' : 'dark'} mode ✨',
                ),
                backgroundColor: AppTheme.goldenColor,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 1),
              ),
            );
          },
          activeThumbColor: AppTheme.goldenColor,
          activeTrackColor: AppTheme.goldenColor.withOpacity(0.3),
          inactiveThumbColor: Colors.white.withOpacity(0.8),
          inactiveTrackColor: Colors.white.withOpacity(0.2),
        ),
      ],
    );
  }

  void _showLogoutDialog(AppProvider provider, BuildContext context) {
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
              provider.logout();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('You have been signed out. See you soon! ✨'),
                  backgroundColor: AppTheme.goldenColor,
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

class _NotificationToggle extends StatefulWidget {
  final String title;
  final bool initialValue;

  const _NotificationToggle({required this.title, required this.initialValue});

  @override
  State<_NotificationToggle> createState() => _NotificationToggleState();
}

class _NotificationToggleState extends State<_NotificationToggle> {
  late bool _value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.notifications_outlined,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ),
        Switch(
          value: _value,
          onChanged: (value) {
            setState(() => _value = value);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${widget.title} ${value ? 'enabled' : 'disabled'} ✨',
                ),
                backgroundColor: AppTheme.goldenColor,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 1),
              ),
            );
          },
          activeThumbColor: AppTheme.goldenColor,
          activeTrackColor: AppTheme.goldenColor.withOpacity(0.3),
          inactiveThumbColor: Colors.white.withOpacity(0.8),
          inactiveTrackColor: Colors.white.withOpacity(0.2),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }
}
