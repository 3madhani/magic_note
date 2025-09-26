// import 'package:flutter/material.dart';

// class ReminderData {
//   final DateTime date;
//   final TimeOfDay time;
//   final RepeatOption repeat;

//   ReminderData({required this.date, required this.time, required this.repeat});

//   factory ReminderData.fromJson(Map<String, dynamic> json) {
//     return ReminderData(
//       date: DateTime.parse(json['date']),
//       time: TimeOfDay(hour: json['timeHour'], minute: json['timeMinute']),
//       repeat: RepeatOption.values[json['repeat']],
//     );
//   }

//   String get repeatText {
//     switch (repeat) {
//       case RepeatOption.none:
//         return 'No Repeat';
//       case RepeatOption.daily:
//         return 'Daily';
//       case RepeatOption.weekly:
//         return 'Weekly';
//       case RepeatOption.monthly:
//         return 'Monthly';
//     }
//   }

//   ReminderData copyWith({
//     DateTime? date,
//     TimeOfDay? time,
//     RepeatOption? repeat,
//   }) {
//     return ReminderData(
//       date: date ?? this.date,
//       time: time ?? this.time,
//       repeat: repeat ?? this.repeat,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'date': date.toIso8601String(),
//       'timeHour': time.hour,
//       'timeMinute': time.minute,
//       'repeat': repeat.index,
//     };
//   }
// }

// enum RepeatOption { none, daily, weekly, monthly }
