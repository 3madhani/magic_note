import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_note/features/notes/domain/entities/note.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/theme_constants.dart';
import '../../../../core/widgets/reminder_modal.dart';
import '../../../../core/widgets/show_snack_bar.dart';
import '../../../app/cubit/app_cubit.dart';
import '../../../app/cubit/app_state.dart';
import '../cubits/note_cubit/notes_cubit.dart';
import '../cubits/reminder_cubit/reminder_cubit.dart';
import '../widgets/note_content_field.dart';
import '../widgets/note_customization.dart';
import '../widgets/note_editor_header.dart';
import '../widgets/note_title_field.dart';

class EditNotePage extends StatefulWidget {
  final Note note;
  const EditNotePage({super.key, required this.note});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  String _selectedColor = AppConstants.defaultColor;
  String _selectedCategory = AppConstants.defaultCategory;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? ThemeConstants.darkNoteColors[_selectedColor]
              : ThemeConstants.noteColors[_selectedColor],
        ),
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, appState) {
            return Stack(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      NoteEditorHeader(
                        title: "Edit Note",
                        onSave: _handleSave,
                        onMenuAction: _handleMenuAction,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              NoteCustomization(
                                selectedColor: _selectedColor,
                                selectedCategory: _selectedCategory,
                                onColorChanged: (c) =>
                                    setState(() => _selectedColor = c),
                                onCategoryChanged: (cat) =>
                                    setState(() => _selectedCategory = cat),
                              ),
                              const SizedBox(height: 24),
                              NoteTitleField(
                                controller: _titleController,
                                selectedColor: _selectedColor,
                              ),
                              const SizedBox(height: 16),
                              Expanded(
                                child: NoteContentField(
                                  controller: _contentController,
                                  selectedColor: _selectedColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                if (appState.isReminderModalOpen)
                  ReminderModal(
                    noteId: widget.note.id,
                    title: widget.note.title,
                    content: widget.note.content,
                    color: isDarkMode
                        ? ThemeConstants.darkNoteColors[_selectedColor]!
                        : ThemeConstants.noteColors[_selectedColor]!,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<ReminderCubit>().loadReminders(widget.note.id);
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _selectedColor = widget.note.color;
    _selectedCategory = widget.note.category;
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'reminder':
        context.read<AppCubit>().openReminderModal();
        break;
      case 'share':
        showSnackBar(
          message: 'Share feature coming soon!',
          color: Theme.of(context).brightness == Brightness.dark
              ? ThemeConstants.darkNoteColors[_selectedColor]!
              : ThemeConstants.noteColors[_selectedColor]!,
          context: context,
        );
        break;
    }
  }

  void _handleSave() {
    context.read<NotesCubit>().updateNote(
      widget.note.copyWith(
        hasReminder: widget.note.hasReminder,
        id: widget.note.id,
        title: _titleController.text,
        content: _contentController.text,
        color: _selectedColor,
        category: _selectedCategory,
        lastModified: DateTime.now(),
      ),
    );

    Navigator.pop(context);
  }
}
