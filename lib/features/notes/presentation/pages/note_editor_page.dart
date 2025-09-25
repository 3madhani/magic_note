import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/theme_constants.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../app/cubit/app_cubit.dart';
import '../../../app/cubit/app_state.dart';
import '../cubit/notes_cubit.dart';

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({super.key});

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  String _selectedColor = AppConstants.defaultColor;
  String _selectedCategory = AppConstants.defaultCategory;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ThemeConstants.noteColors[_selectedColor]!.colors.first
                  .withOpacity(0.1),
              ThemeConstants.noteColors[_selectedColor]!.colors.last
                  .withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(child: _buildEditorContent()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GlassContainer(
            padding: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(12),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: _handleSave,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Create Note',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GlassContainer(
            padding: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(12),
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onSelected: (value) => _handleMenuAction(value),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'reminder',
                  child: Row(
                    children: [
                      Icon(Icons.notifications_outlined),
                      SizedBox(width: 12),
                      Text('Set Reminder'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'share',
                  child: Row(
                    children: [
                      Icon(Icons.share_outlined),
                      SizedBox(width: 12),
                      Text('Share'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildNoteCustomization(),
          const SizedBox(height: 24),
          _buildTitleField(),
          const SizedBox(height: 16),
          Expanded(child: _buildContentField()),
        ],
      ),
    );
  }

  Widget _buildNoteCustomization() {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customize Your Note',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Color: ',
                style: TextStyle(color: Colors.white.withOpacity(0.8)),
              ),
              const SizedBox(width: 8),
              Expanded(child: _buildColorSelection()),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Category: ',
                style: TextStyle(color: Colors.white.withOpacity(0.8)),
              ),
              const SizedBox(width: 8),
              Expanded(child: _buildCategorySelection()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorSelection() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppConstants.colors.length,
        itemBuilder: (context, index) {
          final color = AppConstants.colors[index];
          final gradient = ThemeConstants.noteColors[color]!;
          final isSelected = _selectedColor == color;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedColor = color),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: gradient,
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: Colors.white, width: 3)
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: gradient.colors.first.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 20)
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategorySelection() {
    return DropdownButton<String>(
      value: _selectedCategory,
      dropdownColor: Colors.black87,
      style: const TextStyle(color: Colors.white),
      underline: Container(),
      isExpanded: true,
      items: AppConstants.categories.map((category) {
        return DropdownMenuItem(value: category, child: Text(category));
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() => _selectedCategory = value);
        }
      },
    );
  }

  Widget _buildTitleField() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: ThemeConstants.noteColors[_selectedColor]!.colors
              .map((c) => c.withOpacity(0.1))
              .toList(),
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThemeConstants.noteColors[_selectedColor]!.colors.first
              .withOpacity(0.3),
        ),
      ),
      child: TextField(
        controller: _titleController,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        decoration: const InputDecoration(
          hintText: 'Note title...',
          hintStyle: TextStyle(color: Colors.white54),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget _buildContentField() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: ThemeConstants.noteColors[_selectedColor]!.colors
              .map((c) => c.withOpacity(0.1))
              .toList(),
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThemeConstants.noteColors[_selectedColor]!.colors.first
              .withOpacity(0.3),
        ),
      ),
      child: TextField(
        controller: _contentController,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: Colors.white, height: 1.6),
        decoration: const InputDecoration(
          hintText: 'Start writing your magical note...',
          hintStyle: TextStyle(color: Colors.white54),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(20),
        ),
      ),
    );
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
