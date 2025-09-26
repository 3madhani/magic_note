import 'package:flutter/material.dart';
import '../../../../core/constants/theme_constants.dart';

class ReminderActiveToggle extends StatelessWidget {
  final bool isActive;
  final ValueChanged<bool> onChanged;

  const ReminderActiveToggle({
    super.key,
    required this.isActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            isActive ? Icons.notifications_active : Icons.notifications_off,
            color: isActive
                ? ThemeConstants.goldenColor
                : Colors.white.withOpacity(0.5),
            size: 20,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Active Reminder',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Switch(
            value: isActive,
            onChanged: onChanged,
            activeThumbColor: ThemeConstants.goldenColor,
            activeTrackColor: ThemeConstants.goldenColor.withOpacity(0.3),
            inactiveThumbColor: Colors.white.withOpacity(0.8),
            inactiveTrackColor: Colors.white.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
