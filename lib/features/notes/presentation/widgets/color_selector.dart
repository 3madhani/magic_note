import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/theme_constants.dart';

class ColorSelector extends StatelessWidget {
  final String selectedColor;
  final ValueChanged<String> onColorChanged;

  const ColorSelector({
    super.key,
    required this.selectedColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppConstants.colors.length,
        itemBuilder: (context, index) {
          final color = AppConstants.colors[index];
          final gradient = ThemeConstants.noteColors[color]!;
          final isSelected = selectedColor == color;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onColorChanged(color),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: gradient,
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(
                          color: Theme.of(context).colorScheme.onSurface,
                          width: 3,
                        )
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: gradient.colors.first.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 20,
                      )
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
