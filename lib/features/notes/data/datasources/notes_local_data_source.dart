import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/note_model.dart';
import '../models/reminder_model.dart';

abstract class NotesLocalDataSource {
  Future<void> addSampleNotes();
  Future<void> deleteNote(String id);
  Future<void> deleteReminder(String id);
  Future<List<NoteModel>> getAllNotes();
  Future<NoteModel?> getNoteById(String id);
  Future<List<ReminderModel>> getRemindersForNote(String noteId);
  Future<void> saveNote(NoteModel note);
  Future<void> saveReminder(ReminderModel reminder);
  Future<List<NoteModel>> searchNotes(String query);
  Future<void> updateNote(NoteModel note);
  Future<void> updateReminder(ReminderModel reminder);
}

class NotesLocalDataSourceImpl implements NotesLocalDataSource {
  final SharedPreferences sharedPreferences;

  NotesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> addSampleNotes() async {
    try {
      final existingNotes = await getAllNotes();
      if (existingNotes.isNotEmpty) return;

      final sampleNotes = [
        NoteModel(
          id: '1',
          title: '✨ Welcome to Magic Notes',
          content:
              'This is your first magical note! You can create, edit, and set reminders for all your thoughts.',
          category: 'Welcome',
          color: 'purple',
          hasReminder: false,
          lastModified: DateTime.now().subtract(const Duration(hours: 1)),
          createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        NoteModel(
          id: '2',
          title: '🎯 Goals for Today',
          content:
              '• Learn something new\n• Exercise for 30 minutes\n• Call family\n• Work on personal project',
          category: 'Personal',
          color: 'blue',
          hasReminder: true,
          lastModified: DateTime.now().subtract(const Duration(hours: 2)),
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        NoteModel(
          id: '3',
          title: '💡 Great Ideas',
          content:
              'Sometimes the best ideas come when you least expect them. Keep this note handy for those magical moments of inspiration!',
          category: 'Ideas',
          color: 'yellow',
          hasReminder: false,
          lastModified: DateTime.now().subtract(const Duration(days: 1)),
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];

      await _saveNotes(sampleNotes);
    } catch (e) {
      throw CacheException('Failed to add sample notes: $e');
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    try {
      final notes = await getAllNotes();
      notes.removeWhere((note) => note.id == id);
      await _saveNotes(notes);

      // Also delete associated reminders
      final reminders = await _getAllReminders();
      reminders.removeWhere((reminder) => reminder.noteId == id);
      await _saveReminders(reminders);
    } catch (e) {
      throw CacheException('Failed to delete note: $e');
    }
  }

  @override
  Future<void> deleteReminder(String id) async {
    try {
      final reminders = await _getAllReminders();
      reminders.removeWhere((reminder) => reminder.id == id);
      await _saveReminders(reminders);
    } catch (e) {
      throw CacheException('Failed to delete reminder: $e');
    }
  }

  @override
  Future<List<NoteModel>> getAllNotes() async {
    try {
      final notesJson =
          sharedPreferences.getStringList(AppConstants.notesKey) ?? [];
      return notesJson
          .map((json) => NoteModel.fromJson(jsonDecode(json)))
          .toList()
        ..sort((a, b) => b.lastModified.compareTo(a.lastModified));
    } catch (e) {
      throw CacheException('Failed to get notes: $e');
    }
  }

  @override
  Future<NoteModel?> getNoteById(String id) async {
    try {
      final notes = await getAllNotes();
      return notes.where((note) => note.id == id).firstOrNull;
    } catch (e) {
      throw CacheException('Failed to get note by id: $e');
    }
  }

  @override
  Future<List<ReminderModel>> getRemindersForNote(String noteId) async {
    try {
      final reminders = await _getAllReminders();
      return reminders.where((reminder) => reminder.noteId == noteId).toList();
    } catch (e) {
      throw CacheException('Failed to get reminders: $e');
    }
  }

  @override
  Future<void> saveNote(NoteModel note) async {
    try {
      final notes = await getAllNotes();
      notes.insert(0, note);
      await _saveNotes(notes);
    } catch (e) {
      throw CacheException('Failed to save note: $e');
    }
  }

  @override
  Future<void> saveReminder(ReminderModel reminder) async {
    try {
      final reminders = await _getAllReminders();
      reminders.add(reminder);
      await _saveReminders(reminders);
    } catch (e) {
      throw CacheException('Failed to save reminder: $e');
    }
  }

  @override
  Future<List<NoteModel>> searchNotes(String query) async {
    try {
      final notes = await getAllNotes();
      final lowerQuery = query.toLowerCase();
      return notes
          .where(
            (note) =>
                note.title.toLowerCase().contains(lowerQuery) ||
                note.content.toLowerCase().contains(lowerQuery) ||
                note.category.toLowerCase().contains(lowerQuery),
          )
          .toList();
    } catch (e) {
      throw CacheException('Failed to search notes: $e');
    }
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    try {
      final notes = await getAllNotes();
      final index = notes.indexWhere((n) => n.id == note.id);
      if (index != -1) {
        notes[index] = note;
        await _saveNotes(notes);
      } else {
        throw CacheException('Note not found');
      }
    } catch (e) {
      throw CacheException('Failed to update note: $e');
    }
  }

  @override
  Future<void> updateReminder(ReminderModel reminder) async {
    try {
      final reminders = await _getAllReminders();
      final index = reminders.indexWhere((r) => r.noteId == reminder.noteId);
      if (index != -1) {
        reminders[index] = reminder;
        await _saveReminders(reminders);
      } else {
        throw CacheException('Reminder not found');
      }
    } catch (e) {
      throw CacheException('Failed to update reminder: $e');
    }
  }

  Future<List<ReminderModel>> _getAllReminders() async {
    try {
      final remindersJson = sharedPreferences.getStringList('reminders') ?? [];
      return remindersJson
          .map((json) => ReminderModel.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> _saveNotes(List<NoteModel> notes) async {
    try {
      final notesJson = notes.map((note) => jsonEncode(note.toJson())).toList();
      await sharedPreferences.setStringList(AppConstants.notesKey, notesJson);
    } catch (e) {
      throw CacheException('Failed to save notes: $e');
    }
  }

  Future<void> _saveReminders(List<ReminderModel> reminders) async {
    try {
      final remindersJson = reminders
          .map((reminder) => jsonEncode(reminder.toJson()))
          .toList();
      await sharedPreferences.setStringList('reminders', remindersJson);
    } catch (e) {
      throw CacheException('Failed to save reminders: $e');
    }
  }
}
