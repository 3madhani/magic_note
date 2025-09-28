class AppConstants {
  static const String appName = 'Magic Notes';
  static const String appVersion = '1.0.0';
  static const String developer = 'Magic Notes Team';

  // Storage keys
  static const String authKey = 'isAuthenticated';
  static const String themeKey = 'isDarkMode';
  static const String notesKey = 'notes';
  static const String settingsKey = 'settings';

  // Default values
  static const String defaultCategory = 'Personal';
  static const String defaultColor = 'yellow';
  static const String untitledNote = 'Untitled Note';

  // Supported categories
  static const List<String> categories = [
    'Personal',
    'Work',
    'Ideas',
    'Shopping',
    'Travel',
    'Welcome',
  ];

  // Supported colors
  static const List<String> colors = [
    'yellow',
    'babyblue',
    'blue',
    'green',
    'purple',
    'pink',
    'orange',
  ];
}
