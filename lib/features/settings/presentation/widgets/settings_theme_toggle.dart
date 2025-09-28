import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/settings_cubit.dart';

class SettingsThemeToggle extends StatelessWidget {
  final bool isDarkMode;

  const SettingsThemeToggle({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: Colors.white,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Dark Mode',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Switch(
          value: isDarkMode,
          onChanged: (_) => context.read<SettingsCubit>().toggleDarkMode(),
          activeThumbColor: Colors.white,
          activeTrackColor: Colors.white.withOpacity(0.5),
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.white.withOpacity(0.5),
        ),
      ],
    );
  }
}
