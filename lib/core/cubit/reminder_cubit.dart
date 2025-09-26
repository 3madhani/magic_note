import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../features/notes/domain/entities/reminder.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  ReminderCubit()
    : super(
        ReminderState(
          selectedDate: DateTime.now(),
          selectedTime: TimeOfDay.now(),
          selectedRepeat: RepeatOption.none,
        ),
      );

  void saveReminder() {
    final reminder = Reminder(
      noteId: "",
      isActive: true,
      id: UniqueKey().toString(),
      createdAt: DateTime.now(),
      date: state.selectedDate,
      time: state.selectedTime,
      repeat: state.selectedRepeat,
    );
  }

  void updateDate(DateTime date) => emit(state.copyWith(selectedDate: date));

  void updateRepeat(RepeatOption repeat) =>
      emit(state.copyWith(selectedRepeat: repeat));

  void updateTime(TimeOfDay time) => emit(state.copyWith(selectedTime: time));
}
