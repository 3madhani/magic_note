import 'package:flutter/material.dart';

import '../../../../core/widgets/glass_container.dart';

class NoteEditorHeader extends StatelessWidget {
  final VoidCallback onSave;
  final String title;
  final Function(String) onMenuAction;

  const NoteEditorHeader({
    super.key,
    required this.onSave,
    required this.onMenuAction,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GlassContainer(
            padding: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(12),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: textColor),
              onPressed: onSave,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GlassContainer(
            padding: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(12),
            child: PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: textColor),
              onSelected: onMenuAction,
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'reminder',
                  child: Row(
                    children: [
                      Icon(Icons.notifications_outlined),
                      SizedBox(width: 12),
                      Text('Set Reminder'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'share',
                  child: Row(
                    children: [
                      Icon(Icons.share_outlined),
                      SizedBox(width: 12),
                      Text('Share'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
