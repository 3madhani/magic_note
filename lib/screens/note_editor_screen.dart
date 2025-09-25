// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:provider/provider.dart';

// import '../core/theme/app_theme.dart';
// import '../core/widgets/glass_container.dart';
// import '../providers/app_provider.dart';

// class NoteEditorScreen extends StatefulWidget {
//   const NoteEditorScreen({super.key});

//   @override
//   State<NoteEditorScreen> createState() => _NoteEditorScreenState();
// }

// class _NoteEditorScreenState extends State<NoteEditorScreen>
//     with TickerProviderStateMixin {
//   late TextEditingController _titleController;
//   late TextEditingController _contentController;
//   late String _selectedColor;
//   late String _selectedCategory;

//   final List<String> _colors = [
//     'yellow',
//     'blue',
//     'green',
//     'purple',
//     'pink',
//     'orange',
//   ];
//   final List<String> _categories = [
//     'Personal',
//     'Work',
//     'Ideas',
//     'Shopping',
//     'Travel',
//   ];

//   bool _showToolbar = false;
//   late AnimationController _toolbarController;
//   late Animation<double> _toolbarAnimation;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AppProvider>(
//       builder: (context, provider, child) {
//         final noteGradient = provider.isDarkMode
//             ? AppTheme.darkNoteColors[_selectedColor] ??
//                   AppTheme.darkNoteColors['yellow']!
//             : AppTheme.noteColors[_selectedColor] ??
//                   AppTheme.noteColors['yellow']!;

//         return Scaffold(
//           body: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   noteGradient.colors.first.withOpacity(0.1),
//                   noteGradient.colors.last.withOpacity(0.05),
//                 ],
//               ),
//             ),
//             child: SafeArea(
//               child: Column(
//                 children: [
//                   // Header
//                   _buildHeader(provider),

//                   // Editor content
//                   Expanded(
//                     child: _buildEditorContent(
//                       noteGradient,
//                       provider.isDarkMode,
//                     ),
//                   ),

//                   // Floating toolbar
//                   if (_showToolbar) _buildFloatingToolbar(),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _contentController.dispose();
//     _toolbarController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();

//     final provider = Provider.of<AppProvider>(context, listen: false);
//     final note = provider.currentNote;

//     _titleController = TextEditingController(text: note?.title ?? '');
//     _contentController = TextEditingController(text: note?.content ?? '');
//     _selectedColor = note?.color ?? 'yellow';
//     _selectedCategory = note?.category ?? 'Personal';

//     _toolbarController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _toolbarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _toolbarController, curve: Curves.easeInOut),
//     );

//     // Focus listeners
//     _contentController.addListener(_onContentChanged);
//   }

//   Widget _buildContentField(LinearGradient noteGradient, bool isDarkMode) {
//     return Container(
//           decoration: BoxDecoration(
//             gradient:
//                 noteGradient.colors
//                         .map((c) => c.withOpacity(0.1))
//                         .toList()
//                         .length >=
//                     2
//                 ? LinearGradient(
//                     colors: noteGradient.colors
//                         .map((c) => c.withOpacity(0.1))
//                         .toList(),
//                   )
//                 : null,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(
//               color: noteGradient.colors.first.withOpacity(0.3),
//             ),
//           ),
//           child: TextField(
//             controller: _contentController,
//             maxLines: null,
//             expands: true,
//             textAlignVertical: TextAlignVertical.top,
//             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//               color: isDarkMode ? Colors.white : Colors.black87,
//               height: 1.6,
//             ),
//             decoration: InputDecoration(
//               hintText: 'Start writing your magical note...',
//               hintStyle: TextStyle(
//                 color: isDarkMode
//                     ? Colors.white.withOpacity(0.5)
//                     : Colors.black.withOpacity(0.5),
//               ),
//               border: InputBorder.none,
//               contentPadding: const EdgeInsets.all(20),
//             ),
//           ),
//         )
//         .animate()
//         .fadeIn(duration: 600.ms, delay: 400.ms)
//         .slideY(begin: 0.3, duration: 600.ms);
//   }

//   Widget _buildEditorContent(LinearGradient noteGradient, bool isDarkMode) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           // Note customization
//           _buildNoteCustomization(isDarkMode),

//           const SizedBox(height: 24),

//           // Title field
//           _buildTitleField(noteGradient, isDarkMode),

//           const SizedBox(height: 16),

//           // Content field
//           Expanded(child: _buildContentField(noteGradient, isDarkMode)),
//         ],
//       ),
//     );
//   }

//   Widget _buildFloatingToolbar() {
//     return SlideTransition(
//       position: Tween<Offset>(
//         begin: const Offset(0, 1),
//         end: Offset.zero,
//       ).animate(_toolbarAnimation),
//       child: Container(
//         margin: const EdgeInsets.all(16),
//         child: GlassContainer(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildToolbarButton(Icons.format_bold, 'Bold'),
//               _buildToolbarButton(Icons.format_italic, 'Italic'),
//               _buildToolbarButton(Icons.format_list_bulleted, 'List'),
//               _buildToolbarButton(Icons.format_quote, 'Quote'),
//               _buildToolbarButton(Icons.link, 'Link'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(AppProvider provider) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children: [
//           // Back button
//           GlassContainer(
//                 padding: const EdgeInsets.all(8),
//                 borderRadius: BorderRadius.circular(12),
//                 child: IconButton(
//                   icon: const Icon(Icons.arrow_back, color: Colors.white),
//                   onPressed: () => _handleSave(provider),
//                 ),
//               )
//               .animate()
//               .fadeIn(duration: 400.ms)
//               .slideX(begin: -0.3, duration: 400.ms),

//           const SizedBox(width: 16),

//           // Title
//           Expanded(
//             child:
//                 Text(
//                       provider.currentNote != null
//                           ? 'Edit Note'
//                           : 'Create Note',
//                       style: Theme.of(context).textTheme.headlineSmall
//                           ?.copyWith(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                           ),
//                     )
//                     .animate()
//                     .fadeIn(duration: 400.ms, delay: 100.ms)
//                     .slideX(begin: -0.3, duration: 400.ms),
//           ),

//           // More options
//           GlassContainer(
//                 padding: const EdgeInsets.all(8),
//                 borderRadius: BorderRadius.circular(12),
//                 child: PopupMenuButton<String>(
//                   icon: const Icon(Icons.more_vert, color: Colors.white),
//                   onSelected: (value) => _handleMenuAction(value, provider),
//                   itemBuilder: (context) => [
//                     const PopupMenuItem(
//                       value: 'reminder',
//                       child: Row(
//                         children: [
//                           Icon(Icons.notifications_outlined),
//                           SizedBox(width: 12),
//                           Text('Set Reminder'),
//                         ],
//                       ),
//                     ),
//                     const PopupMenuItem(
//                       value: 'share',
//                       child: Row(
//                         children: [
//                           Icon(Icons.share_outlined),
//                           SizedBox(width: 12),
//                           Text('Share'),
//                         ],
//                       ),
//                     ),
//                     if (provider.currentNote != null)
//                       const PopupMenuItem(
//                         value: 'delete',
//                         child: Row(
//                           children: [
//                             Icon(Icons.delete_outline, color: Colors.red),
//                             SizedBox(width: 12),
//                             Text('Delete', style: TextStyle(color: Colors.red)),
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//               )
//               .animate()
//               .fadeIn(duration: 400.ms, delay: 200.ms)
//               .slideX(begin: 0.3, duration: 400.ms),
//         ],
//       ),
//     );
//   }

//   Widget _buildNoteCustomization(bool isDarkMode) {
//     return GlassContainer(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Customize Your Note',
//             style: Theme.of(context).textTheme.titleMedium?.copyWith(
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Color selection
//           Row(
//             children: [
//               Text(
//                 'Color: ',
//                 style: TextStyle(color: Colors.white.withOpacity(0.8)),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: SizedBox(
//                   height: 40,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: _colors.length,
//                     itemBuilder: (context, index) {
//                       final color = _colors[index];
//                       final gradient = isDarkMode
//                           ? AppTheme.darkNoteColors[color]!
//                           : AppTheme.noteColors[color]!;
//                       final isSelected = _selectedColor == color;

//                       return Padding(
//                         padding: const EdgeInsets.only(right: 8),
//                         child: GestureDetector(
//                           onTap: () => setState(() => _selectedColor = color),
//                           child: Container(
//                             width: 40,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               gradient: gradient,
//                               shape: BoxShape.circle,
//                               border: isSelected
//                                   ? Border.all(color: Colors.white, width: 3)
//                                   : null,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: gradient.colors.first.withOpacity(0.3),
//                                   blurRadius: 8,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: isSelected
//                                 ? const Icon(
//                                     Icons.check,
//                                     color: Colors.white,
//                                     size: 20,
//                                   )
//                                 : null,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 16),

//           // Category selection
//           Row(
//             children: [
//               Text(
//                 'Category: ',
//                 style: TextStyle(color: Colors.white.withOpacity(0.8)),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: DropdownButton<String>(
//                   value: _selectedCategory,
//                   dropdownColor: Colors.black87,
//                   style: const TextStyle(color: Colors.white),
//                   underline: Container(),
//                   isExpanded: true,
//                   items: _categories.map((category) {
//                     return DropdownMenuItem(
//                       value: category,
//                       child: Text(category),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     if (value != null) {
//                       setState(() => _selectedCategory = value);
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, duration: 600.ms);
//   }

//   Widget _buildTitleField(LinearGradient noteGradient, bool isDarkMode) {
//     return Container(
//           decoration: BoxDecoration(
//             gradient:
//                 noteGradient.colors
//                         .map((c) => c.withOpacity(0.1))
//                         .toList()
//                         .length >=
//                     2
//                 ? LinearGradient(
//                     colors: noteGradient.colors
//                         .map((c) => c.withOpacity(0.1))
//                         .toList(),
//                   )
//                 : null,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(
//               color: noteGradient.colors.first.withOpacity(0.3),
//             ),
//           ),
//           child: TextField(
//             controller: _titleController,
//             style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//               color: isDarkMode ? Colors.white : Colors.black87,
//               fontWeight: FontWeight.w600,
//             ),
//             decoration: InputDecoration(
//               hintText: 'Note title...',
//               hintStyle: TextStyle(
//                 color: isDarkMode
//                     ? Colors.white.withOpacity(0.5)
//                     : Colors.black.withOpacity(0.5),
//               ),
//               border: InputBorder.none,
//               contentPadding: const EdgeInsets.all(20),
//             ),
//           ),
//         )
//         .animate()
//         .fadeIn(duration: 600.ms, delay: 200.ms)
//         .slideY(begin: 0.3, duration: 600.ms);
//   }

//   Widget _buildToolbarButton(IconData icon, String tooltip) {
//     return Tooltip(
//       message: tooltip,
//       child: IconButton(
//         icon: Icon(icon, color: Colors.white.withOpacity(0.8)),
//         onPressed: () {
//           // Implement formatting logic here
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('$tooltip formatting applied!'),
//               duration: const Duration(seconds: 1),
//               backgroundColor: AppTheme.goldenColor,
//               behavior: SnackBarBehavior.floating,
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _handleMenuAction(String action, AppProvider provider) {
//     switch (action) {
//       case 'reminder':
//         provider.openReminderModal();
//         break;
//       case 'share':
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Share feature coming soon! ✨'),
//             backgroundColor: AppTheme.goldenColor,
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//         break;
//       case 'delete':
//         _showDeleteDialog(provider);
//         break;
//     }
//   }

//   void _handleSave(AppProvider provider) {
//     provider.saveNote(
//       title: _titleController.text.trim().isNotEmpty
//           ? _titleController.text.trim()
//           : 'Untitled Note',
//       content: _contentController.text.trim(),
//       category: _selectedCategory,
//       color: _selectedColor,
//     );

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Magic note saved successfully! ✨'),
//         backgroundColor: AppTheme.goldenColor,
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }

//   void _onContentChanged() {
//     if (_contentController.text.isNotEmpty && !_showToolbar) {
//       setState(() => _showToolbar = true);
//       _toolbarController.forward();
//     } else if (_contentController.text.isEmpty && _showToolbar) {
//       setState(() => _showToolbar = false);
//       _toolbarController.reverse();
//     }
//   }

//   void _showDeleteDialog(AppProvider provider) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: Colors.black87,
//         title: const Text('Delete Note', style: TextStyle(color: Colors.white)),
//         content: const Text(
//           'Are you sure you want to delete this note? This action cannot be undone.',
//           style: TextStyle(color: Colors.white70),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               if (provider.currentNote != null) {
//                 provider.deleteNote(provider.currentNote!.id);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Note deleted successfully! 🗑️'),
//                     backgroundColor: Colors.red,
//                     behavior: SnackBarBehavior.floating,
//                   ),
//                 );
//               }
//             },
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//             child: const Text('Delete', style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }
// }
