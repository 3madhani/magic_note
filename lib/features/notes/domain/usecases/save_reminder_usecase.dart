import 'package:magic_note/core/usecases/usecase.dart';

import '../entities/reminder.dart';
import '../repositories/notes_repository.dart';

class SaveReminderUsecase implements UseCase<void, SaveReminderUsecaseParams> {
  final NotesRepository repository;
  SaveReminderUsecase(this.repository);
  @override
  Future<void> call(SaveReminderUsecaseParams params) async {
    return repository.saveReminder(params.reminder);
  }
}

class SaveReminderUsecaseParams {
  final Reminder reminder;
  SaveReminderUsecaseParams({required this.reminder});
}
