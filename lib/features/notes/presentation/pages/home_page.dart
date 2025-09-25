import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:magic_note/core/constants/theme_constants.dart';

import '../../../../core/utils/data_formatter.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/magical_text.dart';
import '../../../app/cubit/app_cubit.dart';
import '../../../app/cubit/app_state.dart';
import '../../domain/entities/note.dart';
import '../cubit/notes_cubit.dart';
import '../cubit/notes_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _searchController = TextEditingController();

  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  late AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        if (state is NotesLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is NotesError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        if (state is NotesLoaded) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  _buildHeader(),
                  _buildSearchAndFilters(state),
                  Expanded(child: _buildNotesGrid(state.filteredNotes)),
                ],
              ),
            ),
            floatingActionButton: _buildFloatingActionButton(),
          );
        }

        return const Scaffold(body: SizedBox.shrink());
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fabController, curve: Curves.easeInOut));
    _fabController.forward();

    // Load notes when screen opens
    context.read<NotesCubit>().loadNotes();
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: ThemeConstants.golden,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ThemeConstants.goldenColor.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.note_add,
                  size: 60,
                  color: Colors.white,
                ),
              )
              .animate()
              .scale(duration: 800.ms, curve: Curves.easeOutBack)
              .then()
              .shimmer(duration: 2000.ms),
          const SizedBox(height: 32),
          const MagicalText(
            text: 'Create Your First Note',
            gradientColors: [
              Color(0xFFfbbf24),
              Color(0xFFf59e0b),
              Color(0xFFfbbf24),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Start your magical journey by creating\nyour first note. Tap the ✨ button below!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ).animate().fadeIn(duration: 800.ms, delay: 600.ms),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return ScaleTransition(
      scale: _fabAnimation,
      child:
          FloatingActionButton.extended(
                onPressed: () {
                  context.read<AppCubit>().navigateToScreen(AppScreen.editor);
                },
                backgroundColor: ThemeConstants.goldenColor,
                elevation: 12,
                label: const Text(
                  'Create Note ✨',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                icon: const Icon(Icons.add, color: Colors.white),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 3000.ms, color: Colors.white.withOpacity(0.2)),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MagicalText(
                  text: '✨ Magic Notes',
                  gradientColors: [
                    Color(0xFFfbbf24),
                    Color(0xFFf59e0b),
                    Color(0xFFfbbf24),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                      'Good ${AppDateFormatter.getGreeting()}! Ready to create some magic?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 200.ms)
                    .slideX(begin: -0.3, duration: 600.ms),
              ],
            ),
          ),
          GlassContainer(
                padding: const EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(12),
                child: IconButton(
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    context.read<AppCubit>().navigateToScreen(
                      AppScreen.settings,
                    );
                  },
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 400.ms)
              .scale(begin: const Offset(0.5, 0.5), duration: 600.ms),
        ],
      ),
    );
  }

  // void _closeModal() {
  //   _animationController.reverse().then((_) {
  //     context.read<AppCubit>().closeReminderModal();
  //   });
  // }

  // void _saveReminder() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(
  //         'Reminder set for ${DateFormat('MMM d').format(_selectedDate)} at ${_selectedTime.format(context)}!',
  //       ),
  //       backgroundColor: ThemeConstants.goldenColor,
  //       behavior: SnackBarBehavior.floating,
  //     ),
  //   );
  //   _closeModal();
  // }

  Widget _buildNoteCard(Note note, int index) {
    // TODO: Use MagicalContainer / proper gradients like in your theme
    return GestureDetector(
          onTap: () {
            context.read<AppCubit>().navigateToScreen(AppScreen.editor);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: ThemeConstants.golden,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  note.content,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        )
        .animate(delay: (index * 100).ms)
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, duration: 600.ms)
        .scale(begin: const Offset(0.8, 0.8), duration: 600.ms);
  }

  Widget _buildNotesGrid(List<Note> notes) {
    if (notes.isEmpty) {
      return _buildEmptyState();
    }

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
          return _buildNoteCard(note, index);
        },
      ),
    );
  }

  Widget _buildSearchAndFilters(NotesLoaded state) {
    final categories = ['All', 'Personal', 'Work', 'Ideas', 'Welcome'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Search
          GlassContainer(
                padding: const EdgeInsets.all(4),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search your magical notes...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white.withOpacity(0.8),
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
                            color: isSelected
                                ? null
                                : Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.transparent
                                  : Colors.white.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.8),
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
