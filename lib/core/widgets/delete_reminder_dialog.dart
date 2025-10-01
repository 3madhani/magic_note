import 'package:flutter/material.dart';

class DeleteReminderDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const DeleteReminderDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text('Delete Reminder', style: theme.textTheme.titleMedium),
      content: Text('Are you sure you want to delete this reminder?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel', style: TextStyle(color: theme.hintColor)),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
