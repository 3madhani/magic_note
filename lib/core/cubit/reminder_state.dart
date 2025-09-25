part of 'reminder_cubit.dart';

class ReminderState {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final RepeatOption selectedRepeat;

  ReminderState({
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedRepeat,
  });

  ReminderState copyWith({
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    RepeatOption? selectedRepeat,
  }) {
    return ReminderState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedRepeat: selectedRepeat ?? this.selectedRepeat,
    );
  }
}
