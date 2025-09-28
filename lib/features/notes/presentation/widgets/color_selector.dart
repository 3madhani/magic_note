import 'package:flutter/material.dart';
import 'package:magic_note/core/widgets/glass_container.dart';

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
              child: GlassContainer(
                color: isSelected
                    ? gradient.colors.first
                    : Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(200),
                borderColor: isSelected
                    ? gradient.colors.first.withOpacity(0.5)
                    : Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: gradient,
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(color: gradient.colors.first, width: 3)
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
                      ? Icon(Icons.check, color: Colors.white, size: 24)
                      : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
