import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../../../core/utils/data_formatter.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/magical_text.dart';
import '../../../app/cubit/app_cubit.dart';
import '../../../app/cubit/app_state.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MagicalText(
                  text: '✨ Magic Notes',
                  gradientColors: [
                    ThemeConstants.goldenLight,
                    ThemeConstants.goldenColor,
                    ThemeConstants.goldenLight,
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                      'Good ${AppDateFormatter.getGreeting()}! Ready to create some magic?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                        height: 1.2,
                        wordSpacing: 0.5,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 200.ms)
                    .slideX(begin: -0.3, duration: 600.ms),
              ],
            ),
          ),
          GlassContainer(
                padding: const EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(12),
                child: IconButton(
                  icon: Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    context.read<AppCubit>().navigateToScreen(
                      AppScreen.settings,
                    );
                  },
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 400.ms)
              .scale(begin: const Offset(0.5, 0.5), duration: 600.ms),
        ],
      ),
    );
  }
}
