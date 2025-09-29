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
      hint: const Text('Category', style: TextStyle(color: Colors.black)),
      alignment: Alignment.center,
      icon: const Icon(
        Icons.arrow_drop_down_rounded,
        size: 30,
        color: Colors.black,
      ),
      borderRadius: BorderRadius.circular(12),
      value: selectedCategory,
      dropdownColor: Colors.white,
      style: TextStyle(color: Colors.black),
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
