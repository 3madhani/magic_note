// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../features/app/cubit/app_cubit.dart';
// import '../../features/notes/domain/entities/reminder.dart';
// import '../../features/notes/presentation/cubits/reminder_cubit/reminder_cubit.dart';
// import '../constants/theme_constants.dart';
// import 'delete_reminder_dialog.dart';
// import 'glass_container.dart';
// import 'reminder_action_buttons.dart';
// import 'reminder_active_toggle.dart';
// import 'reminder_date_selector.dart';
// import 'reminder_model_header.dart';
// import 'reminder_repeat_selector.dart';
// import 'reminder_time_selector.dart';
// import 'show_snack_bar.dart';

// class ReminderModalContent extends StatefulWidget {
//   final bool isEditing;
//   final Reminder? existingReminder;
//   final String? noteId;

//   const ReminderModalContent({
//     super.key,
//     required this.isEditing,
//     this.existingReminder,
//     this.noteId,
//   });

//   @override
//   State<ReminderModalContent> createState() => _ReminderModalContentState();
// }

// class _ReminderModalContentState extends State<ReminderModalContent>
//     with TickerProviderStateMixin {
//   late DateTime _selectedDate;
//   late TimeOfDay _selectedTime;
//   late RepeatOption _selectedRepeat;
//   late bool _isActive;
//   late final AnimationController _animationController;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(24),
//       constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
//       child: GlassContainer(
//         padding: const EdgeInsets.all(24),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ReminderModalHeader(
//                 isEditing: widget.isEditing,
//                 isActive: _isActive,
//                 onClose: _closeModal,
//               ),
//               const SizedBox(height: 24),
//               ReminderActiveToggle(
//                 isActive: _isActive,
//                 onChanged: (value) {
//                   setState(() {
//                     _isActive = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 20),
//               ReminderDateSelector(
//                 selectedDate: _selectedDate,
//                 onDateChanged: (value) {
//                   setState(() {
//                     _selectedDate = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 20),
//               ReminderTimeSelector(
//                 selectedTime: _selectedTime,
//                 onTimeChanged: (value) {
//                   setState(() {
//                     _selectedTime = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 20),
//               ReminderRepeatSelector(
//                 selectedRepeat: _selectedRepeat,
//                 onRepeatChanged: (value) {
//                   setState(() {
//                     _selectedRepeat = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 32),
//               ReminderActionButtons(
//                 isEditing: widget.isEditing,
//                 onSave: _saveReminder,
//                 onDelete: widget.existingReminder != null
//                     ? () => _deleteReminder(
//                         existingReminder: widget.existingReminder,
//                       )
//                     : null,
//                 onCancel: _closeModal,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _isActive = widget.existingReminder?.isActive ?? true;
//     _initializeData(existingReminder: widget.existingReminder);
//     _setupAnimations();
//   }

//   void _closeModal() {
//     _animationController.reverse().then((_) {
//       if (mounted) context.read<AppCubit>().closeReminderModal();
//     });
//   }

//   Reminder _createReminderEntity({Reminder? existingReminder}) {
//     return Reminder(
//       id:
//           existingReminder?.id ??
//           DateTime.now().millisecondsSinceEpoch.toString(),
//       noteId: widget.noteId!,
//       date: _selectedDate,
//       time: _selectedTime,
//       repeat: _selectedRepeat,
//       isActive: _isActive,
//       createdAt: existingReminder?.createdAt ?? DateTime.now(),
//     );
//   }

//   void _deleteReminder({Reminder? existingReminder}) {
//     showDialog(
//       context: context,
//       builder: (context) => DeleteReminderDialog(
//         onConfirm: () {
//           context.read<ReminderCubit>().deleteReminder(existingReminder!);
//           _closeModal();
//         },
//       ),
//     );
//   }

//   String _formatReminderText(Reminder reminder) {
//     final dateStr = '${reminder.date.day}/${reminder.date.month}';
//     final timeStr = reminder.time.format(context);
//     final repeatStr = reminder.repeat != RepeatOption.none
//         ? ' (${reminder.repeatText.toLowerCase()})'
//         : '';
//     return '$dateStr at $timeStr$repeatStr';
//   }

//   // -------------------------------
//   // State Helpers
//   // -------------------------------
//   void _initializeData({Reminder? existingReminder}) {
//     if (existingReminder != null) {
//       _selectedDate = existingReminder.date;
//       _selectedTime = existingReminder.time;
//       _selectedRepeat = existingReminder.repeat;
//       _isActive = existingReminder.isActive;
//     } else {
//       _selectedDate = DateTime.now();
//       _selectedTime = TimeOfDay.fromDateTime(_selectedDate);
//       _selectedRepeat = RepeatOption.none;
//       _isActive = true;
//     }
//   }

//   // -------------------------------
//   // Actions
//   // -------------------------------
//   void _saveReminder() {
//     if (widget.noteId == null) {
//       showSnackBar(
//         'Please save the note first before setting a reminder',
//         Colors.orange,
//         context,
//       );
//       return;
//     }

//     final reminder = _createReminderEntity();
//     context.read<ReminderCubit>().addReminder(reminder);

//     final msg = _isActive
//         ? 'Reminder set for ${_formatReminderText(reminder)}'
//         : 'Reminder saved but disabled';

//     showSnackBar(msg, ThemeConstants.goldenColor, context);
//     _closeModal();
//   }

//   void _setupAnimations() {
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _animationController.forward();
//   }
// }
