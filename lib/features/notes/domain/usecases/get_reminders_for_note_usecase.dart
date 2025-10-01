import 'package:magic_note/core/usecases/usecase.dart';

import '../entities/reminder.dart';
import '../repositories/notes_repository.dart';

class GetRemindersForNoteUsecase implements UseCase<List<Reminder>, String> {
  final NotesRepository repository;

  GetRemindersForNoteUsecase(this.repository);

  @override
  Future<List<Reminder>> call(String noteId) async =>
      await repository.getRemindersForNote(noteId);
}
