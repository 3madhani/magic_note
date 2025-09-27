import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../../../core/widgets/magical_text.dart';

class MagicalHeader extends StatelessWidget {
  const MagicalHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: ThemeConstants.golden,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ThemeConstants.goldenColor.withOpacity(0.5),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: const Icon(
                Icons.auto_awesome,
                size: 50,
                color: Colors.white,
              ),
            )
            .animate()
            .scale(duration: 600.ms, curve: Curves.easeOutBack)
            .then()
            .shimmer(duration: 2000.ms, color: Colors.white.withOpacity(0.3)),
        const SizedBox(height: 24),
        const MagicalText(
          text: 'Magic Notes',
          gradientColors: [
            ThemeConstants.goldenDark,
            ThemeConstants.goldenColor,
            ThemeConstants.goldenColor,
            ThemeConstants.goldenDark,
          ],
        ),
        const SizedBox(height: 12),
        Text(
              'Where thoughts become magical',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            )
            .animate()
            .fadeIn(duration: 800.ms, delay: 500.ms)
            .slideY(begin: 0.3, duration: 800.ms),
      ],
    );
  }
}
