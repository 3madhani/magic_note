import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/reminder.dart';
import '../../../domain/usecases/delete_reminder_usecase.dart';
import '../../../domain/usecases/get_reminders_for_note_usecase.dart';
import '../../../domain/usecases/save_reminder_usecase.dart';
import '../../../domain/usecases/update_reminder_usecase.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  final List<Reminder> reminders = [];
  final SaveReminderUsecase saveReminderUsecase;
  final UpdateReminderUsecase updateReminderUsecase;
  final GetRemindersForNoteUsecase getRemindersForNoteUsecase;
  final DeleteReminderUsecase deleteReminderUsecase;

  ReminderCubit({
    required this.saveReminderUsecase,
    required this.updateReminderUsecase,
    required this.getRemindersForNoteUsecase,
    required this.deleteReminderUsecase,
  }) : super(ReminderInitial());

  Future<void> addReminder(Reminder reminder) async {
    try {
      await saveReminderUsecase(reminder);
      reminders.add(reminder);
      emit(RemindersLoaded(List.from(reminders)));
      emit(ReminderOperationSuccess('Reminder added successfully 🎉'));
    } catch (e) {
      emit(RemindersError('Failed to add reminder: ${e.toString()}'));
    }
  }

  Future<void> deleteReminder(Reminder reminder) async {
    try {
      await deleteReminderUsecase(DeleteReminderUsecaseParams(id: reminder.id));
      reminders.removeWhere((r) => r.id == reminder.id);
      emit(RemindersLoaded(List.from(reminders)));
      emit(ReminderOperationSuccess('Reminder deleted successfully 🗑️'));
    } catch (e) {
      emit(RemindersError('Failed to delete reminder: ${e.toString()}'));
    }
  }

  Future<void> loadReminders(String noteId) async {
    emit(RemindersLoading());
    try {
      final loadedReminders = await getRemindersForNoteUsecase(noteId);
      reminders
        ..clear()
        ..addAll(loadedReminders);
      emit(RemindersLoaded(List.from(reminders)));
    } catch (e) {
      emit(RemindersError('Failed to load reminders: ${e.toString()}'));
    }
  }

  Future<void> updateReminder(Reminder reminder) async {
    try {
      await updateReminderUsecase(reminder);
      final index = reminders.indexWhere((r) => r.id == reminder.id);
      if (index != -1) {
        reminders[index] = reminder;
        emit(RemindersLoaded(List.from(reminders)));
        emit(ReminderOperationSuccess('Reminder updated successfully ✨'));
      } else {
        emit(RemindersError('Reminder not found'));
      }
    } catch (e) {
      emit(RemindersError('Failed to update reminder: ${e.toString()}'));
    }
  }
}
