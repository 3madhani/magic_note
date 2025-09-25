import '../../domain/entities/settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';
import '../models/settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<Settings> getSettings() async {
    final settingsModel = await localDataSource.getSettings();
    return settingsModel.toEntity();
  }

  @override
  Future<void> resetSettings() async {
    await localDataSource.clearSettings();
  }

  @override
  Future<void> updateSettings(Settings settings) async {
    final settingsModel = SettingsModel.fromEntity(settings);
    await localDataSource.saveSettings(settingsModel);
  }
}
