part of 'reminder_cubit.dart';

sealed class ReminderState extends Equatable {
  const ReminderState();

  @override
  List<Object> get props => [];
}

final class ReminderInitial extends ReminderState {}

final class RemindersLoading extends ReminderState {}

final class RemindersLoaded extends ReminderState {
  final List<Reminder> reminders;

  const RemindersLoaded(this.reminders);

  @override
  List<Object> get props => [reminders];
}

final class RemindersError extends ReminderState {
  final String message;

  const RemindersError(this.message);

  @override
  List<Object> get props => [message];
}

final class ReminderOperationSuccess extends ReminderState {
  final String message;

  const ReminderOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

