import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/settings_cubit.dart';

class SettingsThemeToggle extends StatelessWidget {
  final bool isDarkMode;

  const SettingsThemeToggle({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(
          isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: colors.onSurface,
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
          activeThumbColor: colors.secondary,
          activeTrackColor: colors.secondary.withOpacity(0.3),
          inactiveThumbColor: colors.onSurface,
          inactiveTrackColor: colors.onSurfaceVariant.withOpacity(0.3),
        ),
      ],
    );
  }
}
