import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_note/core/constants/theme_constants.dart';

import '../cubit/notes_cubit.dart';
import '../cubit/notes_state.dart';
import '../widgets/create_note_fab.dart';
import '../widgets/home_header.dart';
import '../widgets/notes_grid.dart';
import '../widgets/search_and_filters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _searchController = TextEditingController();

  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark
        ? true
        : false;
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        if (state is NotesLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is NotesError) {
          return Scaffold(
            body: Center(
              child: Text(
                state.message,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          );
        }

        if (state is NotesLoaded) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDarkMode
                      ? [
                          ThemeConstants.darkBackground,
                          ThemeConstants.darkBackground.withOpacity(0.6),
                        ]
                      : [const Color(0xFF667eea), const Color(0xFF764ba2)],
                ),
              ),
              child: Stack(
                children: [
                  SafeArea(
                    child: Column(
                      children: [
                        const HomeHeader(),
                        SearchAndFilters(
                          searchController: _searchController,
                          state: state,
                        ),

                        Expanded(child: NotesGrid(notes: state.filteredNotes)),
                      ],
                    ),
                  ),
                  buildSelectionActions(context, state, _fabAnimation),
                ],
              ),
            ),
            floatingActionButton: CreateNoteFab(animation: _fabAnimation),
          );
        }

        return const Scaffold(body: SizedBox.shrink());
      },
    );
  }

  Positioned buildSelectionActions(
    BuildContext context,
    NotesLoaded state,
    Animation<double> fabAnimation,
  ) {
    final hasSelection = state.selectedNotes.isNotEmpty;

    return Positioned(
      bottom: 200,
      right: 24,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeOutBack,
        switchOutCurve: Curves.easeInBack,
        transitionBuilder: (child, animation) {
          final slide = Tween<Offset>(
            begin: const Offset(0.3, 0), // slide from right
            end: Offset.zero,
          ).animate(animation);

          return SlideTransition(
            position: slide,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: hasSelection
            ? Column(
                key: const ValueKey("fab-actions"),
                children: [
                  FloatingActionButton(
                    heroTag: 'selected_count_fab',
                    elevation: 3,

                    onPressed: null,
                    backgroundColor: ThemeConstants.goldenDark.withOpacity(0.8),
                    child: Text(
                      state.selectedNotes.length.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FloatingActionButton(
                    heroTag: 'delete_notes_fab',
                    onPressed: () {
                      context.read<NotesCubit>().deleteNotes();
                    },
                    backgroundColor: Colors.redAccent,
                    child: const Icon(
                      Icons.delete,
                      size: 26,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FloatingActionButton(
                    heroTag: 'clear_selection_fab',
                    onPressed: () {
                      context.read<NotesCubit>().clearSelectedNotes();
                    },
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: const Icon(
                      Icons.close,
                      size: 26,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(key: ValueKey("fab-empty")),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // FAB animation
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fabController, curve: Curves.easeInOut));
    _fabController.forward();

    // Load notes on screen open
    context.read<NotesCubit>().loadNotes();
  }
}
