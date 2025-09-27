import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/notes_repository.dart';

class CreateNoteParams {
  final String title;
  final String content;
  final String category;
  final String color;
  final bool hasReminder;

  CreateNoteParams({
    required this.title,
    required this.content,
    required this.category,
    required this.color,
    required this.hasReminder ,
  });
}

class CreateNoteUseCase implements UseCase<void, CreateNoteParams> {
  final NotesRepository repository;

  CreateNoteUseCase(this.repository);

  @override
  Future<void> call(CreateNoteParams params) async {
    final note = Note(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: params.title,
      content: params.content,
      category: params.category,
      color: params.color,
      hasReminder: params.hasReminder,
      lastModified: DateTime.now(),
      createdAt: DateTime.now(),
    );

    await repository.saveNote(note);
  }
}
