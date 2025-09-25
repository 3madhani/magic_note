import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/widgets/magical_text.dart';

class HomeEmptyState extends StatelessWidget {
  const HomeEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.secondary, colors.primary],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colors.secondary.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Icon(Icons.note_add, size: 60, color: colors.onPrimary),
              )
              .animate()
              .scale(duration: 800.ms, curve: Curves.easeOutBack)
              .then()
              .shimmer(duration: 2000.ms),
          const SizedBox(height: 32),
          MagicalText(
            text: 'Create Your First Note',
            gradientColors: [
              colors.secondary,
              colors.primary,
              colors.secondary,
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Start your magical journey by creating\nyour first note. Tap the ✨ button below!',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: colors.onSurfaceVariant),
          ).animate().fadeIn(duration: 800.ms, delay: 600.ms),
        ],
      ),
    );
  }
}
