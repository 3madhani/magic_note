import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/notes_repository.dart';

class SearchNotesParams {
  final String query;

  SearchNotesParams({required this.query});
}

class SearchNotesUseCase implements UseCase<List<Note>, SearchNotesParams> {
  final NotesRepository repository;

  SearchNotesUseCase(this.repository);

  @override
  Future<List<Note>> call(SearchNotesParams params) async {
    if (params.query.trim().isEmpty) {
      return await repository.getAllNotes();
    }
    return await repository.searchNotes(params.query);
  }
}
