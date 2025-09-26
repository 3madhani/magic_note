import 'package:flutter/material.dart';
import '../../../../core/constants/theme_constants.dart';

class ReminderModalHeader extends StatelessWidget {
  final bool isEditing;
  final bool isActive;
  final VoidCallback onClose;

  const ReminderModalHeader({
    super.key,
    required this.isEditing,
    required this.isActive,
    required this.onClose,
  });

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
          child: Icon(
            isActive ? Icons.notifications_active : Icons.notifications_off,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            isEditing ? 'Edit Reminder' : 'Set Reminder',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
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
