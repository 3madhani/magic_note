import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/theme_constants.dart';
import '../../../../core/widgets/reminder_modal.dart';
import '../../../app/cubit/app_cubit.dart';
import '../../../app/cubit/app_state.dart';
import '../cubits/note_cubit/notes_cubit.dart';
import '../cubits/note_cubit/notes_state.dart';
import '../widgets/note_content_field.dart';
import '../widgets/note_customization.dart';
import '../widgets/note_editor_header.dart';
import '../widgets/note_title_field.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  String _selectedColor = AppConstants.defaultColor;
  String _selectedCategory = AppConstants.defaultCategory;
  late String? noteId;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, appState) {
          return BlocListener<NotesCubit, NotesState>(
            listener: (context, state) {
              if (state is NoteOperationSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: ThemeConstants.goldenColor,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDarkMode
                      ? [const Color(0xFF0f0f23), const Color(0xFF1a1a2e)]
                      : [const Color(0xFF667eea), const Color(0xFF764ba2)],
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ThemeConstants.noteColors[_selectedColor]!.colors.first,
                      ThemeConstants
                          .darkNoteColors[_selectedColor]!
                          .colors
                          .first,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    SafeArea(
                      child: Column(
                        children: [
                          NoteEditorHeader(
                            title: 'Create Note',
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ThemeConstants
                                      .noteColors[_selectedColor]!
                                      .colors[1],
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: noteId != null
                                    ? null
                                    : () {
                                        noteId = DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString();

                                        context.read<NotesCubit>().createNote(
                                          noteId: noteId!,
                                          title: _titleController.text,
                                          content: _contentController.text,
                                          category: _selectedCategory,
                                          color: _selectedColor,
                                        );
                                      },
                                child: const Text(
                                  'Save Note',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (appState.isReminderModalOpen)
                      ReminderModal(
                        // existingReminder: widget.note.hasReminder
                        //     ? widget.note.reminder
                        //     : null,
                        noteId: noteId,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
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
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    noteId = null;
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'reminder':
        context.read<AppCubit>().openReminderModal();
        break;
      case 'share':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Share feature coming soon!'),
            backgroundColor: ThemeConstants.goldenColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
        break;
    }
  }

  void _handleSave() {
    noteId ??= DateTime.now().millisecondsSinceEpoch.toString();
    context.read<NotesCubit>().createNote(
      noteId: noteId!,
      title: _titleController.text,
      content: _contentController.text,
      category: _selectedCategory,
      color: _selectedColor,
    );

    context.read<AppCubit>().navigateToScreen(AppScreen.home);
  }
}
