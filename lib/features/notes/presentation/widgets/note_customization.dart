import 'package:flutter/material.dart';

import '../../../../core/widgets/glass_container.dart';
import 'category_selector.dart';
import 'color_selector.dart';

class NoteCustomization extends StatelessWidget {
  final String selectedColor;
  final String selectedCategory;
  final ValueChanged<String> onColorChanged;
  final ValueChanged<String> onCategoryChanged;

  const NoteCustomization({
    super.key,
    required this.selectedColor,
    required this.selectedCategory,
    required this.onColorChanged,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.black;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customize Your Note',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Color:',
                style: TextStyle(color: textColor.withOpacity(0.8)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ColorSelector(
                  selectedColor: selectedColor,
                  onColorChanged: onColorChanged,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Category:',
                style: TextStyle(color: textColor.withOpacity(0.8)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CategorySelector(
                  selectedCategory: selectedCategory,
                  onCategoryChanged: onCategoryChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
