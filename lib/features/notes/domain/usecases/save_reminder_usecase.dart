import '../../../../core/usecases/usecase.dart';
import '../entities/reminder.dart';
import '../repositories/notes_repository.dart';

class SaveReminderUsecase implements UseCase<void, Reminder> {
  final NotesRepository repository;
  SaveReminderUsecase(this.repository);
  @override
  Future<void> call(Reminder params) async {
    return repository.saveReminder(params);
  }
}
