import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                      ? [const Color(0xFF0f0f23), const Color(0xFF1a1a2e)]
                      : [const Color(0xFF667eea), const Color(0xFF764ba2)],
                ),
              ),
              child: SafeArea(
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
            ),
            floatingActionButton: CreateNoteFab(animation: _fabAnimation),
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
