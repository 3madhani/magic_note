import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/settings_model.dart';

abstract class SettingsLocalDataSource {
  Future<void> clearSettings();
  Future<SettingsModel> getSettings();
  Future<void> saveSettings(SettingsModel settings);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> clearSettings() async {
    try {
      await sharedPreferences.remove(AppConstants.settingsKey);
    } catch (e) {
      throw CacheException('Failed to clear settings: $e');
    }
  }

  @override
  Future<SettingsModel> getSettings() async {
    try {
      final settingsJson = sharedPreferences.getString(
        AppConstants.settingsKey,
      );
      if (settingsJson != null) {
        return SettingsModel.fromJson(jsonDecode(settingsJson));
      }
      return SettingsModel.defaults;
    } catch (e) {
      // Return defaults if there's an error
      return SettingsModel.defaults;
    }
  }

  @override
  Future<void> saveSettings(SettingsModel settings) async {
    try {
      await sharedPreferences.setString(
        AppConstants.settingsKey,
        jsonEncode(settings.toJson()),
      );
    } catch (e) {
      throw CacheException('Failed to save settings: $e');
    }
  }
}
