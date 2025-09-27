import 'package:flutter/material.dart';

class SettingsLanguageSelector extends StatelessWidget {
  const SettingsLanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(Icons.language, color: colors.onSurface),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Language',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: colors.surfaceContainerHigh.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colors.outline.withOpacity(0.4)),
          ),
          child: Text(
            'English',
            style: TextStyle(color: colors.onSurface, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
