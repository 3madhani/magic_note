import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/theme_constants.dart';
import '../../features/notes/presentation/cubits/note_cubit/notes_cubit.dart';
import '../../features/notes/presentation/cubits/note_cubit/notes_state.dart';

class ReminderActionButtons extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onSave;
  final VoidCallback? onDelete;
  final VoidCallback onCancel;

  const ReminderActionButtons({
    super.key,
    required this.isEditing,
    required this.onSave,
    this.onDelete,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isEditing && onDelete != null) ...[
          _buildDeleteButton(),
          const SizedBox(height: 12),
        ],
        Row(
          children: [
            Expanded(child: _buildCancelButton()),
            const SizedBox(width: 16),
            Expanded(child: _buildSaveButton(context)),
          ],
        ),
      ],
    );
  }

  Widget _buildDeleteButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onDelete,
        icon: const Icon(Icons.delete_outline, color: Colors.red),
        label: const Text(
          'Delete Reminder',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return OutlinedButton(
      onPressed: onCancel,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.white.withOpacity(0.5)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(
        'Cancel',
        style: TextStyle(
          color: Colors.white.withOpacity(0.8),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        final isLoading = state is NotesLoading;
        return ElevatedButton(
          onPressed: isLoading ? null : onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeConstants.goldenColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 8,
            shadowColor: ThemeConstants.goldenColor.withOpacity(0.3),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  isEditing ? 'Update Reminder' : 'Set Reminder',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        );
      },
    );
  }
}
