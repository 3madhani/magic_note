import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../domain/entities/note.dart';
import '../widgets/note_card.dart';
import 'empty_notes_state.dart';

class NotesGrid extends StatelessWidget {
  final List<Note> notes;

  const NotesGrid({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) return const EmptyNotesState();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: MasonryGridView.builder(
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        physics: const BouncingScrollPhysics(),
        mainAxisSpacing: 26,
        crossAxisSpacing: 26,

        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return NoteCard(note: note, index: index);
        },
      ),
    );
  }
}
