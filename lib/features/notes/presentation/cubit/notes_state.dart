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
  final List<Note> selectedNotes;
  final String searchQuery;
  final String selectedCategory;

  const NotesLoaded({
    this.selectedNotes = const [],
    required this.notes,
    required this.filteredNotes,
    this.searchQuery = '',
    this.selectedCategory = 'All',
  });

  @override
  List<Object?> get props => [
    selectedNotes,
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

class SelectionMode extends NotesLoaded {
  @override
  final List<Note> selectedNotes;

  const SelectionMode({
    required super.notes,
    required super.filteredNotes,
    required this.selectedNotes,
    super.selectedCategory,
    super.searchQuery,
  });

  @override
  List<Object?> get props => super.props + [selectedNotes];
  @override
  SelectionMode copyWith({
    List<Note>? notes,
    List<Note>? filteredNotes,
    List<Note>? selectedNotes,
    String? selectedCategory,
    String? searchQuery,
  }) {
    return SelectionMode(
      notes: notes ?? this.notes,
      filteredNotes: filteredNotes ?? this.filteredNotes,
      selectedNotes: selectedNotes ?? this.selectedNotes,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
