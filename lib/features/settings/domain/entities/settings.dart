class Settings {
  final bool isDarkMode;
  final String language;
  final bool pushNotifications;
  final bool reminderAlerts;
  final bool weeklySummary;
  final bool autoBackup;
  final DateTime lastUpdated;

  const Settings({
    required this.isDarkMode,
    required this.language,
    required this.pushNotifications,
    required this.reminderAlerts,
    required this.weeklySummary,
    required this.autoBackup,
    required this.lastUpdated,
  });

  Settings copyWith({
    bool? isDarkMode,
    String? language,
    bool? pushNotifications,
    bool? reminderAlerts,
    bool? weeklySummary,
    bool? autoBackup,
    DateTime? lastUpdated,
  }) {
    return Settings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      reminderAlerts: reminderAlerts ?? this.reminderAlerts,
      weeklySummary: weeklySummary ?? this.weeklySummary,
      autoBackup: autoBackup ?? this.autoBackup,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  static Settings get defaults => Settings(
    isDarkMode: false,
    language: 'en',
    pushNotifications: true,
    reminderAlerts: true,
    weeklySummary: false,
    autoBackup: false,
    lastUpdated: DateTime.now(),
  );
}
