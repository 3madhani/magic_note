import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/notes_repository.dart';

class GetNotesUseCase implements UseCaseNoParams<List<Note>> {
  final NotesRepository repository;

  GetNotesUseCase(this.repository);

  @override
  Future<List<Note>> call() async {
    return await repository.getAllNotes();
  }
}
