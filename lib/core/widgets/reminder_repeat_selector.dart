import 'package:flutter/material.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../features/notes/domain/entities/reminder.dart';

class ReminderRepeatSelector extends StatelessWidget {
  final RepeatOption selectedRepeat;
  final ValueChanged<RepeatOption> onRepeatChanged;

  const ReminderRepeatSelector({
    super.key,
    required this.selectedRepeat,
    required this.onRepeatChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Repeat',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
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
            children: RepeatOption.values.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              return _buildRepeatOption(option, index);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRepeatOption(RepeatOption option, int index) {
    final isSelected = selectedRepeat == option;
    final isLast = index == RepeatOption.values.length - 1;

    return GestureDetector(
      onTap: () => onRepeatChanged(option),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? ThemeConstants.goldenColor.withOpacity(0.2)
              : null,
          borderRadius: _getBorderRadius(index, isLast),
          border: !isLast ? _getBottomBorder() : null,
        ),
        child: Row(
          children: [
            _buildSelectionIndicator(isSelected),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _getRepeatText(option),
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Colors.white.withOpacity(0.8),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected) _getRepeatIcon(option),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionIndicator(bool isSelected) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? ThemeConstants.goldenColor
              : Colors.white.withOpacity(0.5),
          width: 2,
        ),
        color: isSelected ? ThemeConstants.goldenColor : null,
      ),
      child: isSelected
          ? const Icon(Icons.check, size: 12, color: Colors.white)
          : null,
    );
  }

  BorderRadius? _getBorderRadius(int index, bool isLast) {
    if (isLast) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      );
    } else if (index == 0) {
      return const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      );
    }
    return null;
  }

  Border? _getBottomBorder() {
    return Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1)));
  }

  Icon _getRepeatIcon(RepeatOption option) {
    IconData iconData;
    switch (option) {
      case RepeatOption.none:
        iconData = Icons.event_available;
        break;
      case RepeatOption.daily:
        iconData = Icons.today;
        break;
      case RepeatOption.weekly:
        iconData = Icons.date_range;
        break;
      case RepeatOption.monthly:
        iconData = Icons.calendar_month;
        break;
    }

    return Icon(iconData, color: ThemeConstants.goldenColor, size: 16);
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
}
