import '../../domain/entities/settings.dart';

class SettingsModel extends Settings {
  static SettingsModel get defaults => SettingsModel(
    isDarkMode: false,
    language: 'en',
    pushNotifications: true,
    reminderAlerts: true,
    weeklySummary: false,
    autoBackup: false,
    lastUpdated: DateTime.now(),
  );

  const SettingsModel({
    required super.isDarkMode,
    required super.language,
    required super.pushNotifications,
    required super.reminderAlerts,
    required super.weeklySummary,
    required super.autoBackup,
    required super.lastUpdated,
  });

  factory SettingsModel.fromEntity(Settings settings) {
    return SettingsModel(
      isDarkMode: settings.isDarkMode,
      language: settings.language,
      pushNotifications: settings.pushNotifications,
      reminderAlerts: settings.reminderAlerts,
      weeklySummary: settings.weeklySummary,
      autoBackup: settings.autoBackup,
      lastUpdated: settings.lastUpdated,
    );
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      isDarkMode: json['isDarkMode'] ?? false,
      language: json['language'] ?? 'en',
      pushNotifications: json['pushNotifications'] ?? true,
      reminderAlerts: json['reminderAlerts'] ?? true,
      weeklySummary: json['weeklySummary'] ?? false,
      autoBackup: json['autoBackup'] ?? false,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : DateTime.now(),
    );
  }

  Settings toEntity() {
    return Settings(
      isDarkMode: isDarkMode,
      language: language,
      pushNotifications: pushNotifications,
      reminderAlerts: reminderAlerts,
      weeklySummary: weeklySummary,
      autoBackup: autoBackup,
      lastUpdated: lastUpdated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
      'language': language,
      'pushNotifications': pushNotifications,
      'reminderAlerts': reminderAlerts,
      'weeklySummary': weeklySummary,
      'autoBackup': autoBackup,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
