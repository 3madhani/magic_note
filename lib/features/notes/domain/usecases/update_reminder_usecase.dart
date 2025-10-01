import 'package:magic_note/core/usecases/usecase.dart';

import '../entities/reminder.dart';
import '../repositories/notes_repository.dart';

class UpdateReminderUsecase implements UseCase<void, Reminder> {
  final NotesRepository repository;

  UpdateReminderUsecase(this.repository);
  @override
  Future<void> call(Reminder params) async =>
      await repository.updateReminder(params);
}
