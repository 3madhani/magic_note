class Validators {
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool isValidNoteTitle(String title) {
    return title.trim().isNotEmpty && title.trim().length <= 100;
  }

  static bool isValidNoteContent(String content) {
    return content.trim().length <= 10000;
  }

  static String? validateNoteTitle(String? title) {
    if (title == null || title.trim().isEmpty) {
      return 'Title cannot be empty';
    }
    if (title.trim().length > 100) {
      return 'Title cannot exceed 100 characters';
    }
    return null;
  }

  static String? validateNoteContent(String? content) {
    if (content != null && content.trim().length > 10000) {
      return 'Content cannot exceed 10,000 characters';
    }
    return null;
  }
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}