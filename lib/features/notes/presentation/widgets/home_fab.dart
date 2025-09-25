// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../app/cubit/app_cubit.dart';
// import '../../../app/cubit/app_state.dart';

// class HomeFab extends StatelessWidget {
//   final Animation<double> animation;

//   const HomeFab({super.key, required this.animation});

//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).colorScheme;

//     return ScaleTransition(
//       scale: animation,
//       child:
//           FloatingActionButton.extended(
//                 onPressed: () {
//                   context.read<AppCubit>().navigateToScreen(AppScreen.editor);
//                 },
//                 backgroundColor: colors.secondary,
//                 elevation: 12,
//                 label: Text(
//                   'Create Note ✨',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: colors.onPrimary,
//                   ),
//                 ),
//                 icon: Icon(Icons.add, color: colors.onPrimary),
//               )
//               .animate(onPlay: (controller) => controller.repeat())
//               .shimmer(
//                 duration: 3000.ms,
//                 color: colors.onPrimary.withOpacity(0.2),
//               ),
//     );
//   }
// }
