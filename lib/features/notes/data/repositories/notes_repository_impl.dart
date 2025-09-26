import '../../domain/entities/note.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/repositories/notes_repository.dart';
import '../datasources/notes_local_data_source.dart';
import '../models/note_model.dart';
import '../models/reminder_model.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesLocalDataSource localDataSource;

  NotesRepositoryImpl({required this.localDataSource});

  @override
  Future<void> deleteNote(String id) async {
    await localDataSource.deleteNote(id);
  }

  @override
  Future<void> deleteReminder(String id) async {
    // Implementation would depend on data source having delete method
    throw UnimplementedError();
  }

  @override
  Future<List<Note>> getAllNotes() async {
    final noteModels = await localDataSource.getAllNotes();
    return noteModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Note?> getNoteById(String id) async {
    final noteModel = await localDataSource.getNoteById(id);
    return noteModel?.toEntity();
  }

  @override
  Future<List<Note>> getNotesByCategory(String category) async {
    final notes = await getAllNotes();
    return notes.where((note) => note.category == category).toList();
  }

  @override
  Future<List<Reminder>> getRemindersForNote(String noteId) async {
    final reminderModels = await localDataSource.getRemindersForNote(noteId);
    return reminderModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> saveNote(Note note) async {
    final noteModel = NoteModel.fromEntity(note);
    await localDataSource.saveNote(noteModel);
  }

  @override
  Future<void> saveReminder(Reminder reminder) async {
    final reminderModel = ReminderModel.fromEntity(reminder);
    await localDataSource.saveReminder(reminderModel);
  }

  @override
  Future<List<Note>> searchNotes(String query) async {
    final noteModels = await localDataSource.searchNotes(query);
    return noteModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> updateNote(Note note) async {
    final noteModel = NoteModel.fromEntity(note);
    await localDataSource.updateNote(noteModel);
  }

  @override
  Future<void> updateReminder(Reminder reminder) async {
    // Implementation would depend on data source having update method
    throw UnimplementedError();
  }
}
