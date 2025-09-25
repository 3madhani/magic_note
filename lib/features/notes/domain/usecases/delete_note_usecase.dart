import '../../../../core/usecases/usecase.dart';
import '../repositories/notes_repository.dart';

class DeleteNoteParams {
  final String noteId;

  DeleteNoteParams({required this.noteId});
}

class DeleteNoteUseCase implements UseCase<void, DeleteNoteParams> {
  final NotesRepository repository;

  DeleteNoteUseCase(this.repository);

  @override
  Future<void> call(DeleteNoteParams params) async {
    await repository.deleteNote(params.noteId);
  }
}
