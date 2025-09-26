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
      id: json['id'] as String,
      noteId: json['noteId'] as String,
      date: DateTime.parse(json['date'] as String),
      time: TimeOfDay(
        hour: (json['time']['hour'] as num).toInt(),
        minute: (json['time']['minute'] as num).toInt(),
      ),
      repeat: RepeatOption.values.firstWhere(
        (e) => e.toString() == 'RepeatOption.${json['repeat']}',
        orElse: () => RepeatOption.none,
      ),
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'noteId': noteId,
      'date': date.toIso8601String(),
      'time': {'hour': time.hour, 'minute': time.minute},
      'repeat': repeat.name,
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
