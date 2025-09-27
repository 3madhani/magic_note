import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class CategorySelector extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      menuWidth: 100,
      hint: const Text('Category'),
      alignment: Alignment.center,
      icon: const Icon(Icons.arrow_drop_down_rounded, size: 26),
      borderRadius: BorderRadius.circular(12),
      value: selectedCategory,
      dropdownColor: Theme.of(context).colorScheme.onPrimary,
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      underline: SizedBox(),
      isExpanded: true,
      items: AppConstants.categories.map((category) {
        return DropdownMenuItem(value: category, child: Text(category));
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          onCategoryChanged(value);
        }
      },
    );
  }
}
