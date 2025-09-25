import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/reminder_data.dart';
import '../../providers/app_provider.dart';
import '../theme/app_theme.dart';
import 'glass_container.dart';

class ReminderModal extends StatefulWidget {
  const ReminderModal({super.key});

  @override
  State<ReminderModal> createState() => _ReminderModalState();
}

class _ReminderModalState extends State<ReminderModal>
    with SingleTickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  RepeatOption _selectedRepeat = RepeatOption.none;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          color: Colors.black.withOpacity(0.5 * _opacityAnimation.value),
          child: Center(
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                margin: const EdgeInsets.all(24),
                constraints: const BoxConstraints(maxWidth: 400),
                child: GlassContainer(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      _buildHeader(),

                      const SizedBox(height: 24),

                      // Date selection
                      _buildDateSection(),

                      const SizedBox(height: 20),

                      // Time selection
                      _buildTimeSection(),

                      const SizedBox(height: 20),

                      // Repeat options
                      _buildRepeatSection(),

                      const SizedBox(height: 32),

                      // Action buttons
                      _buildActionButtons(),
                    ],
                  ),
                ),
              ),
            ),
          ),
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

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _closeModal,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.white.withOpacity(0.5)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: ElevatedButton(
            onPressed: _saveReminder,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.goldenColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 8,
              shadowColor: AppTheme.goldenColor.withOpacity(0.3),
            ),
            child: const Text(
              'Set Reminder ✨',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 12),

        GestureDetector(
          onTap: _selectDate,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: AppTheme.goldenColor,
                  size: 20,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    DateFormat('EEEE, MMMM d, y').format(_selectedDate),
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),

                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.5),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: AppTheme.golden,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.notifications_active,
            color: Colors.white,
            size: 24,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            'Set Reminder',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: _closeModal,
        ),
      ],
    );
  }

  Widget _buildRepeatSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Repeat',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 12),

        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Column(
            children: RepeatOption.values.map((option) {
              final isSelected = _selectedRepeat == option;
              final isLast = option == RepeatOption.values.last;

              return GestureDetector(
                onTap: () => setState(() => _selectedRepeat = option),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.goldenColor.withOpacity(0.2)
                        : null,
                    borderRadius: isLast
                        ? const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          )
                        : option == RepeatOption.values.first
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          )
                        : null,
                    border: !isLast
                        ? Border(
                            bottom: BorderSide(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          )
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppTheme.goldenColor
                                : Colors.white.withOpacity(0.5),
                            width: 2,
                          ),
                          color: isSelected ? AppTheme.goldenColor : null,
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                size: 12,
                                color: Colors.white,
                              )
                            : null,
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          _getRepeatText(option),
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withOpacity(0.8),
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Time',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 12),

        GestureDetector(
          onTap: _selectTime,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time, color: AppTheme.goldenColor, size: 20),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    _selectedTime.format(context),
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),

                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.5),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _closeModal() {
    _animationController.reverse().then((_) {
      final provider = Provider.of<AppProvider>(context, listen: false);
      provider.closeReminderModal();
    });
  }

  String _getRepeatText(RepeatOption option) {
    switch (option) {
      case RepeatOption.none:
        return 'No Repeat';
      case RepeatOption.daily:
        return 'Daily';
      case RepeatOption.weekly:
        return 'Weekly';
      case RepeatOption.monthly:
        return 'Monthly';
    }
  }

  void _saveReminder() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final reminderData = ReminderData(
      date: _selectedDate,
      time: _selectedTime,
      repeat: _selectedRepeat,
    );

    provider.saveReminder(reminderData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Reminder set for ${DateFormat('MMM d').format(_selectedDate)} at ${_selectedTime.format(context)} ✨',
        ),
        backgroundColor: AppTheme.goldenColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: AppTheme.goldenColor),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  Future<void> _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: AppTheme.goldenColor),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }
}
