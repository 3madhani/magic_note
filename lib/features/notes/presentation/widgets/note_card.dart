import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../../../core/utils/data_formatter.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../../settings/presentation/cubit/settings_state.dart';
import '../../domain/entities/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final int index;
  final VoidCallback onTap;

  const NoteCard({
    super.key,
    required this.note,
    required this.index,
    required this.onTap,
  });

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

        return GestureDetector(
              onTap: onTap,
              child: MagicalContainer(
                gradient: noteGradient,
                padding: const EdgeInsets.all(16),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: noteGradient.colors.first.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            note.title,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                          ),
                        ),
                        if (note.hasReminder)
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: ThemeConstants.goldenColor.withOpacity(
                                0.2,
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
                    Text(
                      note.content,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.8)
                            : Colors.black.withOpacity(0.7),
                      ),
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            note.category,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          AppDateFormatter.formatDate(note.lastModified),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
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
