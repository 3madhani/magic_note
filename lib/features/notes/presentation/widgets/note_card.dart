import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../../../core/utils/data_formatter.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../../settings/presentation/cubit/settings_state.dart';
import '../../domain/entities/note.dart';
import '../cubits/note_cubit/notes_cubit.dart';
import '../pages/edit_note_page.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final int index;

  const NoteCard({super.key, required this.note, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settingsState) {
        bool isDarkMode = false;
        if (settingsState is SettingsLoaded) {
          isDarkMode = settingsState.settings.isDarkMode;
        }

        final noteGradient = isDarkMode
            ? ThemeConstants.darkNoteColors[note.color] ??
                  ThemeConstants.darkNoteColors['yellow']!
            : ThemeConstants.noteColors[note.color] ??
                  ThemeConstants.noteColors['yellow']!;

        final textTheme = Theme.of(context).textTheme;

        return GestureDetector(
              onLongPress: () {
                if (context.read<NotesCubit>().selectedNotes.isNotEmpty) {
                  context.read<NotesCubit>().clearSelectedNotes();
                  return;
                }
                context.read<NotesCubit>().toggleNoteSelection(note);
              },
              onTap: () {
                if (context.read<NotesCubit>().selectedNotes.isNotEmpty) {
                  context.read<NotesCubit>().toggleNoteSelection(note);
                  return;
                } else if (context.read<NotesCubit>().selectedNotes.contains(
                  note,
                )) {
                  context.read<NotesCubit>().clearSelectedNotes();
                  return;
                }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return EditNotePage(note: note);
                    },
                  ),
                );
              },
              child: MagicalContainer(
                gradient:
                    context.read<NotesCubit>().selectedNotes.contains(note)
                    ? LinearGradient(
                        colors: noteGradient.colors
                            .map((e) => e.withOpacity(0.5))
                            .toList(),
                      )
                    : noteGradient,
                padding: const EdgeInsets.all(16),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title + Reminder
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            note.title,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                        if (note.hasReminder)
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: ThemeConstants.goldenColor.withOpacity(
                                0.15,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.notifications_active,
                              size: 16,
                              color: ThemeConstants.goldenColor,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    /// Content
                    Text(
                      note.content,
                      style: textTheme.bodyMedium?.copyWith(
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.85)
                            : Colors.black.withOpacity(0.75),
                      ),
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),

                    /// Category + Date
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.12)
                                : Colors.black.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            note.category,
                            style: textTheme.bodySmall?.copyWith(
                              color: isDarkMode ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          AppDateFormatter.formatDate(note.lastModified),
                          style: textTheme.bodySmall?.copyWith(
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.6)
                                : Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
            .animate(delay: (index * 100).ms)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3, duration: 600.ms)
            .scale(begin: const Offset(0.8, 0.8), duration: 600.ms);
      },
    );
  }
}
