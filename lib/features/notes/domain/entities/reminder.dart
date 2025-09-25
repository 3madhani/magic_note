import 'package:flutter/material.dart';

enum RepeatOption { none, daily, weekly, monthly }

class Reminder {
  final String id;
  final String noteId;
  final DateTime date;
  final TimeOfDay time;
  final RepeatOption repeat;
  final bool isActive;
  final DateTime createdAt;

  const Reminder({
    required this.id,
    required this.noteId,
    required this.date,
    required this.time,
    required this.repeat,
    required this.isActive,
    required this.createdAt,
  });

  String get repeatText {
    switch (repeat) {
      case RepeatOption.none:
        return 'No Repeat';
      case RepeatOption.daily:
        return 'Daily';
      case RepeatOption.weekly:
        return 'Weekly';
      case RepeatOption.monthly:
        return 'Monthly';
    }
  }

  Reminder copyWith({
    String? id,
    String? noteId,
    DateTime? date,
    TimeOfDay? time,
    RepeatOption? repeat,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return Reminder(
      id: id ?? this.id,
      noteId: noteId ?? this.noteId,
      date: date ?? this.date,
      time: time ?? this.time,
      repeat: repeat ?? this.repeat,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
