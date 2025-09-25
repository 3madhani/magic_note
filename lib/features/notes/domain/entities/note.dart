class Note {
  final String id;
  final String title;
  final String content;
  final String category;
  final String color;
  final bool hasReminder;
  final DateTime lastModified;
  final DateTime createdAt;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.color,
    required this.hasReminder,
    required this.lastModified,
    required this.createdAt,
  });

  Note copyWith({
    String? id,
    String? title,
    String? content,
    String? category,
    String? color,
    bool? hasReminder,
    DateTime? lastModified,
    DateTime? createdAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      color: color ?? this.color,
      hasReminder: hasReminder ?? this.hasReminder,
      lastModified: lastModified ?? this.lastModified,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
