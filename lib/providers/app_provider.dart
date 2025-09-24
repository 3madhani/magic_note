import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/note.dart';
import '../models/reminder_data.dart';

class AppProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isDarkMode = false;
  AppScreenEnum _currentScreen = AppScreenEnum.auth;
  Note? _currentNote;
  List<Note> _notes = [];
  bool _isReminderModalOpen = false;

  AppProvider() {
    _loadPreferences();
    _loadNotes();
  }
  Note? get currentNote => _currentNote;
  AppScreenEnum get currentScreen => _currentScreen;
  // Getters
  bool get isAuthenticated => _isAuthenticated;
  bool get isDarkMode => _isDarkMode;
  bool get isReminderModalOpen => _isReminderModalOpen;

  List<Note> get notes => _notes;

  // Sample data for demonstration
  void addSampleNotes() {
    if (_notes.isEmpty) {
      _notes.addAll([
        Note(
          id: '1',
          title: '✨ Welcome to Magic Notes',
          content:
              'This is your first magical note! You can create, edit, and set reminders for all your thoughts.',
          category: 'Welcome',
          color: 'purple',
          hasReminder: false,
          lastModified: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        Note(
          id: '2',
          title: '🎯 Goals for Today',
          content:
              '• Learn something new\n• Exercise for 30 minutes\n• Call family\n• Work on personal project',
          category: 'Personal',
          color: 'blue',
          hasReminder: true,
          lastModified: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        Note(
          id: '3',
          title: '💡 Great Ideas',
          content:
              'Sometimes the best ideas come when you least expect them. Keep this note handy for those magical moments of inspiration!',
          category: 'Ideas',
          color: 'yellow',
          hasReminder: false,
          lastModified: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ]);
      _saveNotes();
      notifyListeners();
    }
  }

  void closeReminderModal() {
    _isReminderModalOpen = false;
    notifyListeners();
  }

  Future<void> deleteNote(String noteId) async {
    _notes.removeWhere((note) => note.id == noteId);
    await _saveNotes();
    navigateToHome();
  }

  // Authentication
  Future<void> login() async {
    _isAuthenticated = true;
    _currentScreen = AppScreenEnum.home;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', true);
    notifyListeners();
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _currentScreen = AppScreenEnum.auth;
    _currentNote = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', false);
    notifyListeners();
  }

  void navigateToEditor({Note? note}) {
    _currentNote = note;
    _currentScreen = AppScreenEnum.editor;
    notifyListeners();
  }

  void navigateToHome() {
    _currentNote = null;
    _currentScreen = AppScreenEnum.home;
    notifyListeners();
  }

  // Navigation
  void navigateToScreen(AppScreenEnum screen) {
    _currentScreen = screen;
    notifyListeners();
  }

  // Reminder modal
  void openReminderModal() {
    _isReminderModalOpen = true;
    notifyListeners();
  }

  // Note management
  Future<void> saveNote({
    String? title,
    String? content,
    String? category,
    String? color,
    bool? hasReminder,
  }) async {
    if (_currentNote != null) {
      // Update existing note
      final index = _notes.indexWhere((note) => note.id == _currentNote!.id);
      if (index != -1) {
        _notes[index] = _currentNote!.copyWith(
          title: title ?? _currentNote!.title,
          content: content ?? _currentNote!.content,
          category: category ?? _currentNote!.category,
          color: color ?? _currentNote!.color,
          hasReminder: hasReminder ?? _currentNote!.hasReminder,
          lastModified: DateTime.now(),
        );
      }
    } else {
      // Create new note
      final newNote = Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title ?? 'Untitled',
        content: content ?? '',
        category: category ?? 'General',
        color: color ?? 'yellow',
        hasReminder: hasReminder ?? false,
        lastModified: DateTime.now(),
      );
      _notes.insert(0, newNote);
    }

    await _saveNotes();
    navigateToHome();
  }

  Future<void> saveReminder(ReminderData reminderData) async {
    if (_currentNote != null) {
      final index = _notes.indexWhere((note) => note.id == _currentNote!.id);
      if (index != -1) {
        _notes[index] = _currentNote!.copyWith(hasReminder: true);
        await _saveNotes();
      }
    }
    _isReminderModalOpen = false;
    notifyListeners();
  }

  // Theme management
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  // Load saved notes
  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getStringList('notes') ?? [];
    _notes = notesJson.map((json) => Note.fromJson(jsonDecode(json))).toList();
    notifyListeners();
  }

  // Load saved preferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    if (_isAuthenticated) {
      _currentScreen = AppScreenEnum.home;
    }
    notifyListeners();
  }

  // Save notes to storage
  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = _notes.map((note) => jsonEncode(note.toJson())).toList();
    await prefs.setStringList('notes', notesJson);
  }
}

enum AppScreenEnum { auth, home, editor, settings }
