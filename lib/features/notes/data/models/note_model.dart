import '../../domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel({
    required super.id,
    required super.title,
    required super.content,
    required super.category,
    required super.color,
    required super.hasReminder,
    required super.lastModified,
    required super.createdAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      category: json['category'] as String,
      color: json['color'] as String,
      hasReminder: json['hasReminder'] as bool,
      lastModified: DateTime.parse(json['lastModified'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'color': color,
      'hasReminder': hasReminder,
      'lastModified': lastModified.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory NoteModel.fromEntity(Note note) {
    return NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      category: note.category,
      color: note.color,
      hasReminder: note.hasReminder,
      lastModified: note.lastModified,
      createdAt: note.createdAt,
    );
  }

  Note toEntity() {
    return Note(
      id: id,
      title: title,
      content: content,
      category: category,
      color: color,
      hasReminder: hasReminder,
      lastModified: lastModified,
      createdAt: createdAt,
    );
  }
}
