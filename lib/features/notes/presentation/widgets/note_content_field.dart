import 'package:flutter/material.dart';

import '../../../../core/constants/theme_constants.dart';

class NoteContentField extends StatelessWidget {
  final TextEditingController controller;
  final String selectedColor;

  const NoteContentField({
    super.key,
    required this.controller,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = ThemeConstants.noteColors[selectedColor]!;
    final textColor = Colors.black;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient.colors.map((c) => c.withOpacity(0.1)).toList(),
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: gradient.colors.first.withOpacity(0.3)),
      ),
      child: TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: textColor, height: 1.6),
        decoration: InputDecoration(
          hintText: 'Start writing your magical note...',
          hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
