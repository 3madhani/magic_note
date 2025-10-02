import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/glass_container.dart';
import '../../features/app/cubit/app_cubit.dart';
import '../../features/notes/domain/entities/reminder.dart';
import '../../features/notes/presentation/cubits/reminder_cubit/reminder_cubit.dart';
import 'reminder_action_buttons.dart';
import 'reminder_active_toggle.dart';
import 'reminder_date_selector.dart';
import 'reminder_model_header.dart';
import 'reminder_repeat_selector.dart';
import 'reminder_time_selector.dart';
import 'show_snack_bar.dart';

class ReminderModal extends StatefulWidget {
  final String? noteId;
  final String? title;
  final String? content;
  final LinearGradient color;

  const ReminderModal({
    super.key,
    this.noteId,
    this.title,
    this.content,
    required this.color,
  });

  @override
  State<ReminderModal> createState() => _ReminderModalState();
}

class _ReminderModalState extends State<ReminderModal>
    with SingleTickerProviderStateMixin {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late RepeatOption _selectedRepeat;
  late Reminder? _reminder;
  bool _isActive = true;

  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReminderCubit, ReminderState>(
      listener: (context, state) {
        if (state is RemindersError) {
          showSnackBar(
            message: state.message,
            context: context,
            color: widget.color,
          );
        } else if (state is ReminderOperationSuccess) {
          showSnackBar(
            message: state.message,
            context: context,
            color: widget.color,
          );
        }
        if (state is RemindersLoaded) {
          if (state.reminders.isNotEmpty) {
            _reminder = state.reminders.firstWhere(
              (r) => r.noteId == widget.noteId,
            );
            _isActive = state.reminders
                .firstWhere((r) => r.noteId == widget.noteId)
                .isActive;
            _selectedDate = state.reminders
                .firstWhere((r) => r.noteId == widget.noteId)
                .date;
            _selectedTime = state.reminders
                .firstWhere((r) => r.noteId == widget.noteId)
                .time;
            _selectedRepeat = state.reminders
                .firstWhere((r) => r.noteId == widget.noteId)
                .repeat;
          } else {
            _reminder = null;
          }
        }
      },
      builder: (context, state) {
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Container(
              color: Colors.black.withOpacity(0.5 * _opacityAnimation.value),
              child: Center(
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: _buildModalContent(
                    context,
                    existingReminder:
                        state is RemindersLoaded && state.reminders.isNotEmpty
                        ? state.reminders.firstWhere(
                            (r) => r.noteId == widget.noteId,
                          )
                        : null,
                  ),
                ),
              ),
            );
          },
        );
      },
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
    if (widget.noteId != null) {
      context.read<ReminderCubit>().loadReminders(widget.noteId!);
    }
    _initializeData();
    _setupAnimations();
  }

  /// -------------------------------
  /// UI
  /// -------------------------------
  Widget _buildModalContent(
    BuildContext context, {
    Reminder? existingReminder,
  }) {
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
                isEditing: existingReminder != null,
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
                isEditing: existingReminder != null,
                onSave: _saveReminder,
                onDelete: existingReminder != null
                    ? () => _deleteReminder(existingReminder: existingReminder)
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

  void _confirmDelete({Reminder? existingReminder}) {
    if (existingReminder == null) return;
    context.read<ReminderCubit>().deleteReminder(existingReminder);
    _closeModal();
  }

  /// -------------------------------
  /// Helpers
  /// -------------------------------
  Reminder _createReminderEntity({Reminder? existingReminder}) {
    return Reminder(
      id:
          existingReminder?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      noteId: widget.noteId!,
      date: _selectedDate,
      time: _selectedTime,
      repeat: _selectedRepeat,
      isActive: _isActive,
      createdAt: existingReminder?.createdAt ?? DateTime.now(),
    );
  }

  void _deleteReminder({Reminder? existingReminder}) {
    if (existingReminder == null) return;
    _showDeleteConfirmationDialog(existingReminder: existingReminder);
  }

  String _formatReminderText(Reminder reminder) {
    final dateStr = '${reminder.date.day}/${reminder.date.month}';
    final timeStr = reminder.time.format(context);
    final repeatStr = reminder.repeat != RepeatOption.none
        ? ' (${reminder.repeatText.toLowerCase()})'
        : '';
    return '$dateStr at $timeStr$repeatStr';
  }

  /// -------------------------------
  /// State Handling
  /// -------------------------------
  void _initializeData({Reminder? existingReminder}) {
    if (existingReminder != null) {
      final r = existingReminder;
      _selectedDate = r.date;
      _selectedTime = r.time;
      _selectedRepeat = r.repeat;
      _isActive = r.isActive;
    } else {
      _selectedDate = DateTime.now();
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
      showSnackBar(
        message: 'Please save the note first before setting a reminder',
        context: context,
        color: widget.color,
      );
      return;
    }
    final reminder = _createReminderEntity();

    if (_reminder != null) {
      context.read<ReminderCubit>().updateReminder(
        reminder,
        widget.title,
        widget.content,
      );
    } else {
      context.read<ReminderCubit>().addReminder(
        reminder,
        widget.title,
        widget.content,
      );
    }

    final message = _isActive
        ? 'Reminder set for ${_formatReminderText(reminder)}'
        : 'Reminder saved but disabled';

    showSnackBar(message: message, color: widget.color, context: context);
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

  void _showDeleteConfirmationDialog({Reminder? existingReminder}) {
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
              _confirmDelete(existingReminder: existingReminder);
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
}
