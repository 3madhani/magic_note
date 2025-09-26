import 'package:flutter/material.dart';

import '../../../../core/constants/theme_constants.dart';

class ReminderTimeSelector extends StatelessWidget {
  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const ReminderTimeSelector({
    super.key,
    required this.selectedTime,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Time',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => _selectTime(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: ThemeConstants.goldenColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    selectedTime.format(context),
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
          ),
        ),
      ],
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: ThemeConstants.goldenColor),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      onTimeChanged(time);
    }
  }
}
