import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/notes_repository.dart';

class UpdateNoteParams {
  final Note note;

  UpdateNoteParams({required this.note});
}

class UpdateNoteUseCase implements UseCase<void, UpdateNoteParams> {
  final NotesRepository repository;

  UpdateNoteUseCase(this.repository);

  @override
  Future<void> call(UpdateNoteParams params) async {
    final updatedNote = params.note.copyWith(lastModified: DateTime.now());
    await repository.updateNote(updatedNote);
  }
}
