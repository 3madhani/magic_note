import 'package:flutter/material.dart';

class SettingsOption extends StatelessWidget {
  final String title;
  final String? value;
  final IconData? icon;
  final VoidCallback? onTap;

  const SettingsOption({
    super.key,
    required this.title,
    this.value,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          if (icon != null) Icon(icon, color: colorScheme.onSurfaceVariant),
          if (icon != null) const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: colorScheme.onSurface, fontSize: 16),
            ),
          ),
          if (value != null)
            Text(
              value!,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
          if (icon != null)
            Icon(
              Icons.arrow_forward_ios,
              color: colorScheme.onSurfaceVariant,
              size: 16,
            ),
        ],
      ),
    );
  }
}
