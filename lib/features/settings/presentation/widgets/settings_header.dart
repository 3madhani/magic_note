import 'package:flutter/material.dart';

import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/magical_text.dart';

class SettingsHeader extends StatelessWidget {
  final VoidCallback onBack;

  const SettingsHeader({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          GlassContainer(
            padding: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(12),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: onBack,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: MagicalText(
              text: 'Settings',
              gradientColors: [Colors.purple, Colors.pink, Colors.purple],
            ),
          ),
        ],
      ),
    );
  }
}
