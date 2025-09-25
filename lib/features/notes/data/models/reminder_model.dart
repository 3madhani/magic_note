import 'package:flutter/material.dart';
import '../../domain/entities/reminder.dart';

class ReminderModel extends Reminder {
  const ReminderModel({
    required super.id,
    required super.noteId,
    required super.date,
    required super.time,
    required super.repeat,
    required super.isActive,
    required super.createdAt,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      id: json['id'],
      noteId: json['noteId'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(hour: json['timeHour'], minute: json['timeMinute']),
      repeat: RepeatOption.values[json['repeat']],
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'noteId': noteId,
      'date': date.toIso8601String(),
      'timeHour': time.hour,
      'timeMinute': time.minute,
      'repeat': repeat.index,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ReminderModel.fromEntity(Reminder reminder) {
    return ReminderModel(
      id: reminder.id,
      noteId: reminder.noteId,
      date: reminder.date,
      time: reminder.time,
      repeat: reminder.repeat,
      isActive: reminder.isActive,
      createdAt: reminder.createdAt,
    );
  }

  Reminder toEntity() {
    return Reminder(
      id: id,
      noteId: noteId,
      date: date,
      time: time,
      repeat: repeat,
      isActive: isActive,
      createdAt: createdAt,
    );
  }
}
