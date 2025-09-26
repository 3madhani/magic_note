import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../features/app/cubit/app_cubit.dart';
import '../../features/notes/domain/entities/reminder.dart';
import '../../features/notes/presentation/cubit/notes_cubit.dart';
import '../../features/notes/presentation/cubit/notes_state.dart';
import 'reminder_action_buttons.dart';
import 'reminder_active_toggle.dart';
import 'reminder_date_selector.dart';
import 'reminder_model_header.dart';
import 'reminder_repeat_selector.dart';
import 'reminder_time_selector.dart';

class ReminderModal extends StatefulWidget {
  final String? noteId;
  final Reminder? existingReminder;

  const ReminderModal({super.key, this.noteId, this.existingReminder});

  @override
  State<ReminderModal> createState() => _ReminderModalState();
}

class _ReminderModalState extends State<ReminderModal>
    with SingleTickerProviderStateMixin {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late RepeatOption _selectedRepeat;
  bool _isActive = true;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotesCubit, NotesState>(
      listener: _handleNotesStateChange,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            color: Colors.black.withOpacity(0.5 * _opacityAnimation.value),
            child: Center(
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: _buildModalContent(),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupAnimations();
  }

  Widget _buildModalContent() {
    return Container(
      margin: const EdgeInsets.all(24),
      constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
      child: GlassContainer(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReminderModalHeader(
                isEditing: widget.existingReminder != null,
                isActive: _isActive,
                onClose: _closeModal,
              ),
              const SizedBox(height: 24),
              ReminderActiveToggle(
                isActive: _isActive,
                onChanged: (value) => setState(() => _isActive = value),
              ),
              const SizedBox(height: 20),
              ReminderDateSelector(
                selectedDate: _selectedDate,
                onDateChanged: (date) => setState(() => _selectedDate = date),
              ),
              const SizedBox(height: 20),
              ReminderTimeSelector(
                selectedTime: _selectedTime,
                onTimeChanged: (time) => setState(() => _selectedTime = time),
              ),
              const SizedBox(height: 20),
              ReminderRepeatSelector(
                selectedRepeat: _selectedRepeat,
                onRepeatChanged: (repeat) =>
                    setState(() => _selectedRepeat = repeat),
              ),
              const SizedBox(height: 32),
              ReminderActionButtons(
                isEditing: widget.existingReminder != null,
                onSave: _saveReminder,
                onDelete: widget.existingReminder != null
                    ? _deleteReminder
                    : null,
                onCancel: _closeModal,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _closeModal() {
    _animationController.reverse().then((_) {
      if (mounted) {
        context.read<AppCubit>().closeReminderModal();
      }
    });
  }

  void _confirmDelete() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reminder deleted successfully'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
    _closeModal();
  }

  Reminder _createReminderEntity() {
    return Reminder(
      id:
          widget.existingReminder?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      noteId: widget.noteId!,
      date: _selectedDate,
      time: _selectedTime,
      repeat: _selectedRepeat,
      isActive: _isActive,
      createdAt: widget.existingReminder?.createdAt ?? DateTime.now(),
    );
  }

  void _deleteReminder() {
    if (widget.existingReminder == null) return;
    _showDeleteConfirmationDialog();
  }

  String _formatReminderText(Reminder reminder) {
    final dateStr = 'MMM d'.replaceFirst(
      'MMM d',
      '${reminder.date.day}/${reminder.date.month}',
    );
    final timeStr = reminder.time.format(context);
    final repeatStr = reminder.repeat != RepeatOption.none
        ? ' (${reminder.repeatText.toLowerCase()})'
        : '';
    return '$dateStr at $timeStr$repeatStr';
  }

  void _handleNotesStateChange(BuildContext context, NotesState state) {
    if (state is NoteOperationSuccess) {
      _closeModal();
    } else if (state is NotesError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _initializeData() {
    if (widget.existingReminder != null) {
      _selectedDate = widget.existingReminder!.date;
      _selectedTime = widget.existingReminder!.time;
      _selectedRepeat = widget.existingReminder!.repeat;
      _isActive = widget.existingReminder!.isActive;
    } else {
      _selectedDate = DateTime.now().add(const Duration(hours: 1));
      _selectedTime = TimeOfDay.fromDateTime(_selectedDate);
      _selectedRepeat = RepeatOption.none;
      _isActive = true;
    }
  }

  void _saveReminder() {
    if (widget.noteId == null) {
      _showNoteRequiredMessage();
      return;
    }

    final reminder = _createReminderEntity();
    _showSuccessMessage(reminder);
    _closeModal();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Reminder',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        content: const Text(
          'Are you sure you want to delete this reminder?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white.withOpacity(0.8)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _confirmDelete();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showNoteRequiredMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please save the note first before setting a reminder'),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessMessage(Reminder reminder) {
    final message = _isActive
        ? 'Reminder set for ${_formatReminderText(reminder)}'
        : 'Reminder saved but disabled';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ThemeConstants.goldenColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
