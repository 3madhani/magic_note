import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/settings.dart';
import '../../domain/usecases/get_settings_usecase.dart';
import '../../domain/usecases/update_settings_usecase.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetSettingsUseCase getSettingsUseCase;
  final UpdateSettingsUseCase updateSettingsUseCase;

  SettingsCubit({
    required this.getSettingsUseCase,
    required this.updateSettingsUseCase,
  }) : super(SettingsInitial());

  Future<void> loadSettings() async {
    try {
      emit(SettingsLoading());
      final settings = await getSettingsUseCase();
      emit(SettingsLoaded(settings));
    } catch (e) {
      emit(SettingsError('Failed to load settings: ${e.toString()}'));
    }
  }

  Future<void> toggleDarkMode() async {
    final currentState = state;
    if (currentState is SettingsLoaded) {
      final updatedSettings = currentState.settings.copyWith(
        isDarkMode: !currentState.settings.isDarkMode,
      );
      await updateSettings(updatedSettings);
    }
  }

  Future<void> updateNotificationSetting({
    bool? pushNotifications,
    bool? reminderAlerts,
    bool? weeklySummary,
  }) async {
    final currentState = state;
    if (currentState is SettingsLoaded) {
      final updatedSettings = currentState.settings.copyWith(
        pushNotifications:
            pushNotifications ?? currentState.settings.pushNotifications,
        reminderAlerts: reminderAlerts ?? currentState.settings.reminderAlerts,
        weeklySummary: weeklySummary ?? currentState.settings.weeklySummary,
      );
      await updateSettings(updatedSettings);
    }
  }

  Future<void> updateSettings(Settings settings) async {
    try {
      await updateSettingsUseCase(UpdateSettingsParams(settings: settings));
      // Instead of SettingsUpdated
      emit(SettingsLoaded(settings));
    } catch (e) {
      emit(SettingsError('Failed to update settings: ${e.toString()}'));
    }
  }
}
