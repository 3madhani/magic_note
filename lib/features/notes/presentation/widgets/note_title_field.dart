import 'package:flutter/material.dart';

import '../../../../core/constants/theme_constants.dart';

class NoteTitleField extends StatelessWidget {
  final TextEditingController controller;
  final String selectedColor;

  const NoteTitleField({
    super.key,
    required this.controller,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = ThemeConstants.noteColors[selectedColor]!;
    final textColor = Theme.of(context).colorScheme.onSurface;

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
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: 'Note title...',
          hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
