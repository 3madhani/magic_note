import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../models/reminder_data.dart';

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

  void updateDate(DateTime date) => emit(state.copyWith(selectedDate: date));

  void updateTime(TimeOfDay time) => emit(state.copyWith(selectedTime: time));

  void updateRepeat(RepeatOption repeat) =>
      emit(state.copyWith(selectedRepeat: repeat));

  void saveReminder() {
    final reminder = ReminderData(
      date: state.selectedDate,
      time: state.selectedTime,
      repeat: state.selectedRepeat,
    );
    // TODO: persist reminder (db, service, etc.)
    print('Saved reminder: $reminder');
  }
}
