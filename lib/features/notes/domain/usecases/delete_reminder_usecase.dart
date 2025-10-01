import '../../../../core/usecases/usecase.dart';
import '../repositories/notes_repository.dart';

class DeleteReminderUsecase
    implements UseCase<void, DeleteReminderUsecaseParams> {
  final NotesRepository repository;
  DeleteReminderUsecase(this.repository);
  @override
  Future<void> call(DeleteReminderUsecaseParams params) async =>
      await repository.deleteReminder(params.id);
}

class DeleteReminderUsecaseParams {
  final String id;
  DeleteReminderUsecaseParams({required this.id});
}
