import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../features/app/cubit/app_cubit.dart';
import '../../features/notes/domain/entities/reminder.dart';
import '../../features/notes/presentation/cubits/note_cubit/notes_cubit.dart';
import '../../features/notes/presentation/cubits/note_cubit/notes_state.dart';
import 'reminder_action_buttons.dart';
import 'reminder_active_toggle.dart';
import 'reminder_date_selector.dart';
import 'reminder_model_header.dart';
import 'reminder_repeat_selector.dart';
import 'reminder_time_selector.dart';

class ReminderModal extends StatefulWidget {
  final Reminder? existingReminder;
  final String? noteId;

  const ReminderModal({super.key, this.existingReminder, this.noteId});

  @override
  State<ReminderModal> createState() => _ReminderModalState();
}

class _ReminderModalState extends State<ReminderModal>
    with SingleTickerProviderStateMixin {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late RepeatOption _selectedRepeat;
  bool _isActive = true;

  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotesCubit, NotesState>(
      listener: _handleNotesStateChange,
      listenWhen: (previous, current) => previous != current,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            color: Colors.black.withOpacity(0.5 * _opacityAnimation.value),
            child: Center(
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: _buildModalContent(context),
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

  /// -------------------------------
  /// UI
  /// -------------------------------
  Widget _buildModalContent(BuildContext context) {
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
    _showSnackBar('Reminder deleted successfully', Colors.red);
    _closeModal();
  }

  /// -------------------------------
  /// Helpers
  /// -------------------------------
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
    final dateStr = '${reminder.date.day}/${reminder.date.month}';
    final timeStr = reminder.time.format(context);
    final repeatStr = reminder.repeat != RepeatOption.none
        ? ' (${reminder.repeatText.toLowerCase()})'
        : '';
    return '$dateStr at $timeStr$repeatStr';
  }

  void _handleNotesStateChange(BuildContext context, NotesState state) {
    if (state is NoteOperationSuccess) {
      _closeModal();
      _showSnackBar(state.message, ThemeConstants.goldenColor);
    } else if (state is NotesError) {
      _showSnackBar(state.message, Colors.red);
    } else if (state is NoteCreationSuccess) {}
  }

  /// -------------------------------
  /// State Handling
  /// -------------------------------
  void _initializeData() {
    if (widget.existingReminder != null) {
      final r = widget.existingReminder!;
      _selectedDate = r.date;
      _selectedTime = r.time;
      _selectedRepeat = r.repeat;
      _isActive = r.isActive;
    } else {
      _selectedDate = DateTime.now().add(const Duration(hours: 1));
      _selectedTime = TimeOfDay.fromDateTime(_selectedDate);
      _selectedRepeat = RepeatOption.none;
      _isActive = true;
    }
  }

  /// -------------------------------
  /// Actions
  /// -------------------------------
  void _saveReminder() {
    if (widget.noteId == null) {
      _showSnackBar(
        'Please save the note first before setting a reminder',
        Colors.orange,
      );
      return;
    }

    final reminder = _createReminderEntity();
    final message = _isActive
        ? 'Reminder set for ${_formatReminderText(reminder)}'
        : 'Reminder saved but disabled';

    _showSnackBar(message, ThemeConstants.goldenColor);
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
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete Reminder',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this reminder?',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel', style: TextStyle(color: theme.hintColor)),
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
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.down,
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
