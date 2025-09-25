import 'package:flutter/material.dart';

import '../../core/constants/theme_constants.dart';

class ReminderHeader extends StatelessWidget {
  final VoidCallback onClose;

  const ReminderHeader({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: ThemeConstants.golden,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.notifications_active,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Set Reminder',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: onClose,
        ),
      ],
    );
  }
}
