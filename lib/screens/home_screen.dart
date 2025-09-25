// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:provider/provider.dart';

// import '../core/widgets/glass_container.dart';
// import '../models/note.dart';
// import '../providers/app_provider.dart';
// import '../core/theme/app_theme.dart';
// import '../core/widgets/magical_text.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   final _searchController = TextEditingController();
//   String _searchQuery = '';
//   String _selectedCategory = 'All';

//   late AnimationController _fabController;
//   late Animation<double> _fabAnimation;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AppProvider>(
//       builder: (context, provider, child) {
//         final filteredNotes = _getFilteredNotes(provider.notes);

//         return Scaffold(
//           body: SafeArea(
//             child: Column(
//               children: [
//                 // Header
//                 _buildHeader(provider),

//                 // Search and filters
//                 _buildSearchAndFilters(),

//                 // Notes grid
//                 Expanded(child: _buildNotesGrid(filteredNotes)),
//               ],
//             ),
//           ),
//           floatingActionButton: _buildFloatingActionButton(provider),
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _fabController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fabController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _fabAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(parent: _fabController, curve: Curves.easeInOut));
//     _fabController.forward();
//   }

//   Widget _buildCategoryFilters() {
//     final categories = ['All', 'Personal', 'Work', 'Ideas', 'Welcome'];

//     return SizedBox(
//       height: 40,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           final category = categories[index];
//           final isSelected = _selectedCategory == category;

//           return Padding(
//                 padding: EdgeInsets.only(
//                   left: index == 0 ? 0 : 8,
//                   right: index == categories.length - 1 ? 0 : 8,
//                 ),
//                 child: GestureDetector(
//                   onTap: () => setState(() => _selectedCategory = category),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 8,
//                     ),
//                     decoration: BoxDecoration(
//                       gradient: isSelected ? AppTheme.golden : null,
//                       color: isSelected ? null : Colors.white.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                         color: isSelected
//                             ? Colors.transparent
//                             : Colors.white.withOpacity(0.3),
//                       ),
//                     ),
//                     child: Text(
//                       category,
//                       style: TextStyle(
//                         color: isSelected
//                             ? Colors.white
//                             : Colors.white.withOpacity(0.8),
//                         fontWeight: isSelected
//                             ? FontWeight.w600
//                             : FontWeight.normal,
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//               .animate(delay: (index * 100).ms)
//               .fadeIn(duration: 400.ms)
//               .scale(begin: const Offset(0.8, 0.8), duration: 400.ms);
//         },
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//                 alignment: Alignment.center,
//                 width: 120,
//                 height: 120,
//                 decoration: BoxDecoration(
//                   gradient: AppTheme.golden,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppTheme.goldenColor.withOpacity(0.3),
//                       blurRadius: 30,
//                       spreadRadius: 10,
//                     ),
//                   ],
//                 ),
//                 child: const Icon(
//                   Icons.note_add,
//                   size: 60,
//                   color: Colors.white,
//                 ),
//               )
//               .animate()
//               .scale(duration: 800.ms, curve: Curves.easeOutBack)
//               .then()
//               .shimmer(duration: 2000.ms),

//           const SizedBox(height: 32),

//           MagicalText(
//             text: 'Create Your First Note',
//             gradientColors: [
//               Color(0xFFfbbf24),
//               Color(0xFFf59e0b),
//               Color(0xFFfbbf24),
//             ],
//           ),

//           const SizedBox(height: 16),

//           Text(
//             'Start your magical journey by creating\nyour first note. Tap the ✨ button below!',
//             textAlign: TextAlign.center,
//             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//               color: Colors.white.withOpacity(0.8),
//             ),
//           ).animate().fadeIn(duration: 800.ms, delay: 600.ms),
//         ],
//       ),
//     );
//   }

//   Widget _buildFloatingActionButton(AppProvider provider) {
//     return ScaleTransition(
//       scale: _fabAnimation,
//       child:
//           FloatingActionButton.extended(
//                 onPressed: () => provider.navigateToEditor(),
//                 backgroundColor: AppTheme.goldenColor,
//                 elevation: 12,
//                 label: const Text(
//                   'Create Note ✨',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//                 icon: const Icon(Icons.add, color: Colors.white),
//               )
//               .animate(onPlay: (controller) => controller.repeat())
//               .shimmer(duration: 3000.ms, color: Colors.white.withOpacity(0.2)),
//     );
//   }

//   Widget _buildHeader(AppProvider provider) {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 MagicalText(
//                   text: '✨ Magic Notes',
//                   gradientColors: [
//                     Color(0xFFfbbf24),
//                     Color(0xFFf59e0b),
//                     Color(0xFFfbbf24),
//                   ],
//                 ),

//                 const SizedBox(height: 4),

//                 Text(
//                       'Good ${_getGreeting()}! Ready to create some magic?',
//                       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                         color: Colors.white.withOpacity(0.8),
//                       ),
//                     )
//                     .animate()
//                     .fadeIn(duration: 600.ms, delay: 200.ms)
//                     .slideX(begin: -0.3, duration: 600.ms),
//               ],
//             ),
//           ),

//           // Settings button
//           GlassContainer(
//                 padding: const EdgeInsets.all(8),
//                 borderRadius: BorderRadius.circular(12),
//                 child: IconButton(
//                   icon: const Icon(
//                     Icons.settings_outlined,
//                     color: Colors.white,
//                   ),
//                   onPressed: () =>
//                       provider.navigateToScreen(AppScreenEnum.settings),
//                 ),
//               )
//               .animate()
//               .fadeIn(duration: 600.ms, delay: 400.ms)
//               .scale(begin: const Offset(0.5, 0.5), duration: 600.ms),
//         ],
//       ),
//     );
//   }

//   Widget _buildNoteCard(Note note, int index) {
//     final provider = Provider.of<AppProvider>(context, listen: false);
//     final noteGradient = provider.isDarkMode
//         ? AppTheme.darkNoteColors[note.color] ??
//               AppTheme.darkNoteColors['yellow']!
//         : AppTheme.noteColors[note.color] ?? AppTheme.noteColors['yellow']!;

//     return GestureDetector(
//           onTap: () => provider.navigateToEditor(note: note),
//           child: MagicalContainer(
//             gradient: noteGradient,
//             padding: const EdgeInsets.all(16),
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: (noteGradient.colors.first).withOpacity(0.3),
//                 blurRadius: 10,
//                 offset: const Offset(0, 0),
//               ),
//             ],
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Note header
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         note.title,
//                         style: Theme.of(context).textTheme.titleMedium
//                             ?.copyWith(
//                               fontWeight: FontWeight.w600,
//                               color: provider.isDarkMode
//                                   ? Colors.white
//                                   : Colors.black87,
//                             ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     if (note.hasReminder)
//                       Container(
//                         padding: const EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           color: AppTheme.goldenColor.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         child: Icon(
//                           Icons.notifications_active,
//                           size: 16,
//                           color: AppTheme.goldenColor,
//                         ),
//                       ),
//                   ],
//                 ),

//                 const SizedBox(height: 12),

//                 // Note content
//                 Text(
//                   note.content,
//                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     color: provider.isDarkMode
//                         ? Colors.white.withOpacity(0.8)
//                         : Colors.black.withOpacity(0.7),
//                   ),
//                   maxLines: 6,
//                   overflow: TextOverflow.ellipsis,
//                 ),

//                 const SizedBox(height: 12),

//                 // Note footer
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         note.category,
//                         style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                           color: provider.isDarkMode
//                               ? Colors.white
//                               : Colors.black87,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     const Spacer(),
//                     Text(
//                       _formatDate(note.lastModified),
//                       style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                         color: provider.isDarkMode
//                             ? Colors.white.withOpacity(0.6)
//                             : Colors.black.withOpacity(0.5),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         )
//         .animate(delay: (index * 100).ms)
//         .fadeIn(duration: 600.ms)
//         .slideY(begin: 0.3, duration: 600.ms)
//         .scale(begin: const Offset(0.8, 0.8), duration: 600.ms);
//   }

//   Widget _buildNotesGrid(List<Note> notes) {
//     if (notes.isEmpty) {
//       return _buildEmptyState();
//     }

//     return Padding(
//       padding: const EdgeInsets.all(24),
//       child: MasonryGridView.builder(
//         gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//         ),
//         physics: const BouncingScrollPhysics(),
//         shrinkWrap: true,
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         mainAxisSpacing: 35,
//         crossAxisSpacing: 35,
//         itemCount: notes.length,
//         itemBuilder: (context, index) {
//           final note = notes[index];
//           return _buildNoteCard(note, index);
//         },
//       ),
//     );
//   }

//   Widget _buildSearchAndFilters() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       child: Column(
//         children: [
//           // Search bar
//           GlassContainer(
//                 padding: const EdgeInsets.all(4),
//                 child: TextField(
//                   controller: _searchController,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: 'Search your magical notes...',
//                     hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
//                     prefixIcon: Icon(
//                       Icons.search,
//                       color: Colors.white.withOpacity(0.8),
//                     ),
//                     border: InputBorder.none,
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 12,
//                     ),
//                   ),
//                   onChanged: (value) => setState(() => _searchQuery = value),
//                 ),
//               )
//               .animate()
//               .fadeIn(duration: 600.ms, delay: 600.ms)
//               .slideY(begin: 0.3, duration: 600.ms),

//           const SizedBox(height: 16),

//           // Category filters
//           _buildCategoryFilters(),
//         ],
//       ),
//     );
//   }

//   String _formatDate(DateTime date) {
//     final now = DateTime.now();
//     final difference = now.difference(date);

//     if (difference.inMinutes < 1) {
//       return 'now';
//     } else if (difference.inHours < 1) {
//       return '${difference.inMinutes}m';
//     } else if (difference.inDays < 1) {
//       return '${difference.inHours}h';
//     } else if (difference.inDays < 7) {
//       return '${difference.inDays}d';
//     } else {
//       return '${date.day}/${date.month}';
//     }
//   }

//   List<Note> _getFilteredNotes(List<Note> notes) {
//     var filtered = notes;

//     // Filter by search query
//     if (_searchQuery.isNotEmpty) {
//       filtered = filtered
//           .where(
//             (note) =>
//                 note.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
//                 note.content.toLowerCase().contains(_searchQuery.toLowerCase()),
//           )
//           .toList();
//     }

//     // Filter by category
//     if (_selectedCategory != 'All') {
//       filtered = filtered
//           .where((note) => note.category == _selectedCategory)
//           .toList();
//     }

//     return filtered;
//   }

//   String _getGreeting() {
//     final hour = DateTime.now().hour;
//     if (hour < 12) return 'morning';
//     if (hour < 17) return 'afternoon';
//     return 'evening';
//   }
// }
