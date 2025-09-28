import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../../../core/widgets/magical_text.dart';

class EmptyNotesState extends StatelessWidget {
  const EmptyNotesState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: ThemeConstants.golden,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: ThemeConstants.goldenColor.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child:
                  Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          gradient: ThemeConstants.golden,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ThemeConstants.goldenColor.withOpacity(
                                0.3,
                              ),
                              blurRadius: 30,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.note_add,
                          size: 60,
                          color: Colors.white,
                        ),
                      )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .scale(duration: 800.ms, curve: Curves.easeOutBack)
                      .then()
                      .shimmer(
                        duration: 2000.ms,
                        delay: 200.ms,
                        curve: Curves.linear,
                        color: Colors.white,
                      ),
            ),
          ),
          const SizedBox(height: 32),
          const MagicalText(
            text: 'Create Your First Note',
            gradientColors: [
              Color(0xFFfbbf24),
              Color(0xFFf59e0b),
              Color(0xFFfbbf24),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Start your magical journey by creating\nyour first note. Tap the ✨ button below!',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.white),
          ).animate().fadeIn(duration: 800.ms, delay: 600.ms),
        ],
      ),
    );
  }
}
