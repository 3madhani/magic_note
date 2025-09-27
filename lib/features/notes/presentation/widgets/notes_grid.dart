import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:magic_note/features/notes/presentation/pages/update_note_page.dart';

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
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return NoteCard(
            note: note,
            index: index,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return UpdateNotePage(note: note);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
