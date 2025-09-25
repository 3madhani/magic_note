import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/magical_text.dart';
import '../../../../core/utils/data_formatter.dart';
import '../../../app/cubit/app_cubit.dart';
import '../../../app/cubit/app_state.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withOpacity(0.8)
        : Colors.black.withOpacity(0.7);

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
                    Color(0xFFfbbf24),
                    Color(0xFFf59e0b),
                    Color(0xFFfbbf24),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                      'Good ${AppDateFormatter.getGreeting()}! Ready to create some magic?',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: textColor),
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
                    color: Theme.of(context).iconTheme.color,
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
