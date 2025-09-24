class Note {
  final String id;
  final String title;
  final String content;
  final String category;
  final String color;
  final bool hasReminder;
  final DateTime lastModified;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.color,
    required this.hasReminder,
    required this.lastModified,
  });

  Note copyWith({
    String? id,
    String? title,
    String? content,
    String? category,
    String? color,
    bool? hasReminder,
    DateTime? lastModified,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      color: color ?? this.color,
      hasReminder: hasReminder ?? this.hasReminder,
      lastModified: lastModified ?? this.lastModified,
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
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      category: json['category'],
      color: json['color'],
      hasReminder: json['hasReminder'],
      lastModified: DateTime.parse(json['lastModified']),
    );
  }
}