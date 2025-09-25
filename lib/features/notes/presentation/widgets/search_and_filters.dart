import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../../../core/widgets/glass_container.dart';
import '../cubit/notes_cubit.dart';
import '../cubit/notes_state.dart';

class SearchAndFilters extends StatelessWidget {
  final TextEditingController searchController;
  final NotesLoaded state;

  const SearchAndFilters({
    super.key,
    required this.searchController,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Personal', 'Work', 'Ideas', 'Welcome'];
    final brightness = Theme.of(context).brightness;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Search Bar
          GlassContainer(
                padding: const EdgeInsets.all(4),
                child: TextField(
                  controller: searchController,
                  style: TextStyle(
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black87,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search your magical notes...',
                    hintStyle: TextStyle(
                      color: brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.6)
                          : Colors.black.withOpacity(0.6),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.8)
                          : Colors.black.withOpacity(0.7),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (value) =>
                      context.read<NotesCubit>().searchNotes(value),
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 600.ms)
              .slideY(begin: 0.3, duration: 600.ms),

          const SizedBox(height: 16),

          // Categories
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = state.selectedCategory == category;

                return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 0 : 8,
                        right: index == categories.length - 1 ? 0 : 8,
                      ),
                      child: GestureDetector(
                        onTap: () => context
                            .read<NotesCubit>()
                            .filterByCategory(category),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: isSelected ? ThemeConstants.golden : null,
                            color: !isSelected
                                ? (brightness == Brightness.dark
                                      ? Colors.white.withOpacity(0.1)
                                      : Colors.black.withOpacity(0.05))
                                : null,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.transparent
                                  : brightness == Brightness.dark
                                  ? Colors.white.withOpacity(0.3)
                                  : Colors.black.withOpacity(0.2),
                            ),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : (brightness == Brightness.dark
                                        ? Colors.white.withOpacity(0.8)
                                        : Colors.black87),
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    )
                    .animate(delay: (index * 100).ms)
                    .fadeIn(duration: 400.ms)
                    .scale(begin: const Offset(0.8, 0.8), duration: 400.ms);
              },
            ),
          ),
        ],
      ),
    );
  }
}
