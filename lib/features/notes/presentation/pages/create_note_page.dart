import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/theme_constants.dart';
import '../../../app/cubit/app_cubit.dart';
import '../../../app/cubit/app_state.dart';
import '../cubit/notes_cubit.dart';
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

  @override
  Widget build(BuildContext context) {
    final gradient = ThemeConstants.noteColors[_selectedColor]!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradient.colors.first.withOpacity(isDarkMode ? 0.1 : 0.3),
              gradient.colors.last.withOpacity(isDarkMode ? 0.05 : 0.2),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
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
            ],
          ),
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
    _titleController = TextEditingController();
    _contentController = TextEditingController();
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
    context.read<NotesCubit>().createNote(
      title: _titleController.text,
      content: _contentController.text,
      category: _selectedCategory,
      color: _selectedColor,
    );

    context.read<AppCubit>().navigateToScreen(AppScreen.home);
  }
}
