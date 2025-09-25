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
      id: json['id'],
      title: json['title'],
      content: json['content'],
      category: json['category'],
      color: json['color'],
      hasReminder: json['hasReminder'],
      lastModified: DateTime.parse(json['lastModified']),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.parse(json['lastModified']), // Fallback for legacy data
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
