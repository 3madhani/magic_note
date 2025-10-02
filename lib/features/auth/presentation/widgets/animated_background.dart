import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/theme_constants.dart';

class AnimatedBackground extends StatelessWidget {
  final AnimationController floatingController;
  final AnimationController rotationController;

  const AnimatedBackground({
    super.key,
    required this.floatingController,
    required this.rotationController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 80,
          right: 20,
          child: AnimatedBuilder(
            animation: floatingController,
            builder: (_, _) => Transform.translate(
              offset: Offset(0, floatingController.value * 20),
              child:
                  Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: ThemeConstants.magicalPurple,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF8b5cf6).withOpacity(0.4),
                              blurRadius: 40,
                              spreadRadius: 7,
                            ),
                          ],
                        ),
                      )
                      .animate(onPlay: (c) => c.repeat())
                      .shimmer(duration: 2000.ms, padding: 20),
            ),
          ),
        ),
        Positioned(
          top: 200,
          left: 30,
          child: AnimatedBuilder(
            animation: floatingController,
            builder: (_, __) => Transform.translate(
              offset: Offset(0, -floatingController.value * 15),
              child:
                  Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          gradient: ThemeConstants.golden,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ThemeConstants.goldenColor.withOpacity(
                                0.4,
                              ),
                              blurRadius: 40,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                      )
                      .animate(delay: 500.ms, onPlay: (c) => c.repeat())
                      .shimmer(duration: 2500.ms, padding: 20),
            ),
          ),
        ),
        Positioned(
          bottom: 150,
          left: 80,
          child: AnimatedBuilder(
            animation: rotationController,
            builder: (_, __) => Transform.rotate(
              angle: rotationController.value * 2 * 3.14159,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: ThemeConstants.magicalPink,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFec4899).withOpacity(0.4),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          right: 80,
          child: AnimatedBuilder(
            animation: rotationController,
            builder: (_, __) => Transform.rotate(
              angle: rotationController.value * 2 * 3.14159,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: ThemeConstants.magicalPink,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFec4899).withOpacity(0.4),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
