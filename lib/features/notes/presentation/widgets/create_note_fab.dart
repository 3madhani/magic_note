import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../../app/cubit/app_cubit.dart';
import '../../../app/cubit/app_state.dart';

class CreateNoteFab extends StatelessWidget {
  final Animation<double> animation;

  const CreateNoteFab({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child:
          FloatingActionButton.extended(
                onPressed: () {
                  context.read<AppCubit>().navigateToScreen(AppScreen.create);
                },
                backgroundColor: ThemeConstants.goldenColor,
                elevation: 12,
                label: const Text(
                  'Create Note ✨',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                icon: const Icon(Icons.add, color: Colors.white),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 3000.ms, color: Colors.white.withOpacity(0.2)),
    );
  }
}
