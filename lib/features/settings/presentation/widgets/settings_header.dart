import 'package:flutter/material.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/magical_text.dart';

class SettingsHeader extends StatelessWidget {
  final VoidCallback onBack;

  const SettingsHeader({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          GlassContainer(
            padding: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(12),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: onBack,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: MagicalText(
              text: 'Settings',
              gradientColors: [
                of.colorScheme.secondary,
                of.colorScheme.primary,
                of.colorScheme.secondary,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
