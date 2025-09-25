import 'package:equatable/equatable.dart';

import '../../domain/entities/note.dart';

class NoteOperationSuccess extends NotesState {
  final String message;

  const NoteOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class NotesError extends NotesState {
  final String message;

  const NotesError(this.message);

  @override
  List<Object?> get props => [message];
}

class NotesInitial extends NotesState {}

class NotesLoaded extends NotesState {
  final List<Note> notes;
  final List<Note> filteredNotes;
  final String searchQuery;
  final String selectedCategory;

  const NotesLoaded({
    required this.notes,
    required this.filteredNotes,
    this.searchQuery = '',
    this.selectedCategory = 'All',
  });

  @override
  List<Object?> get props => [
    notes,
    filteredNotes,
    searchQuery,
    selectedCategory,
  ];

  NotesLoaded copyWith({
    List<Note>? notes,
    List<Note>? filteredNotes,
    String? searchQuery,
    String? selectedCategory,
  }) {
    return NotesLoaded(
      notes: notes ?? this.notes,
      filteredNotes: filteredNotes ?? this.filteredNotes,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class NotesLoading extends NotesState {}

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object?> get props => [];
}
