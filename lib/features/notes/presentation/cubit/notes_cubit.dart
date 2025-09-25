import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/note.dart';
import '../../domain/usecases/create_note_usecase.dart';
import '../../domain/usecases/delete_note_usecase.dart';
import '../../domain/usecases/get_notes_usecase.dart';
import '../../domain/usecases/search_notes_usecase.dart';
import '../../domain/usecases/update_note_usecase.dart';
import '../../../notes/data/datasources/notes_local_data_source.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final GetNotesUseCase getNotesUseCase;
  final CreateNoteUseCase createNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final SearchNotesUseCase searchNotesUseCase;
  final NotesLocalDataSource localDataSource;

  NotesCubit({
    required this.getNotesUseCase,
    required this.createNoteUseCase,
    required this.updateNoteUseCase,
    required this.deleteNoteUseCase,
    required this.searchNotesUseCase,
    required this.localDataSource,
  }) : super(NotesInitial());

  Future<void> loadNotes() async {
    try {
      emit(NotesLoading());
      final notes = await getNotesUseCase();
      emit(NotesLoaded(notes: notes, filteredNotes: notes));
    } catch (e) {
      emit(NotesError('Failed to load notes: ${e.toString()}'));
    }
  }

  Future<void> createNote({
    required String title,
    required String content,
    required String category,
    required String color,
  }) async {
    try {
      await createNoteUseCase(
        CreateNoteParams(
          title: title.trim().isEmpty ? AppConstants.untitledNote : title,
          content: content,
          category: category,
          color: color,
        ),
      );

      emit(const NoteOperationSuccess('Note created successfully! ✨'));
      await loadNotes();
    } catch (e) {
      emit(NotesError('Failed to create note: ${e.toString()}'));
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      await updateNoteUseCase(UpdateNoteParams(note: note));
      emit(const NoteOperationSuccess('Note updated successfully! ✨'));
      await loadNotes();
    } catch (e) {
      emit(NotesError('Failed to update note: ${e.toString()}'));
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await deleteNoteUseCase(DeleteNoteParams(noteId: noteId));
      emit(const NoteOperationSuccess('Note deleted successfully! 🗑️'));
      await loadNotes();
    } catch (e) {
      emit(NotesError('Failed to delete note: ${e.toString()}'));
    }
  }

  Future<void> searchNotes(String query) async {
    final currentState = state;
    if (currentState is NotesLoaded) {
      try {
        final filteredNotes = await searchNotesUseCase(
          SearchNotesParams(query: query),
        );
        emit(
          currentState.copyWith(
            filteredNotes: filteredNotes,
            searchQuery: query,
          ),
        );
      } catch (e) {
        emit(NotesError('Failed to search notes: ${e.toString()}'));
      }
    }
  }

  void filterByCategory(String category) {
    final currentState = state;
    if (currentState is NotesLoaded) {
      List<Note> filteredNotes;
      if (category == 'All') {
        filteredNotes = currentState.notes;
      } else {
        filteredNotes = currentState.notes
            .where((note) => note.category == category)
            .toList();
      }

      // Apply search filter if there's a search query
      if (currentState.searchQuery.isNotEmpty) {
        final query = currentState.searchQuery.toLowerCase();
        filteredNotes = filteredNotes
            .where(
              (note) =>
                  note.title.toLowerCase().contains(query) ||
                  note.content.toLowerCase().contains(query),
            )
            .toList();
      }

      emit(
        currentState.copyWith(
          filteredNotes: filteredNotes,
          selectedCategory: category,
        ),
      );
    }
  }

  Future<void> addSampleNotes() async {
    try {
      await localDataSource.addSampleNotes();
      await loadNotes();
    } catch (e) {
      emit(NotesError('Failed to add sample notes: ${e.toString()}'));
    }
  }

  void clearMessages() {
    final currentState = state;
    if (currentState is NotesLoaded) {
      // Keep the current loaded state without changing it
      return;
    }
    if (currentState is NoteOperationSuccess || currentState is NotesError) {
      loadNotes();
    }
  }
}
