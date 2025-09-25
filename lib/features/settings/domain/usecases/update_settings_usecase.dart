import '../../../../core/usecases/usecase.dart';
import '../entities/settings.dart';
import '../repositories/settings_repository.dart';

class UpdateSettingsParams {
  final Settings settings;

  UpdateSettingsParams({required this.settings});
}

class UpdateSettingsUseCase implements UseCase<void, UpdateSettingsParams> {
  final SettingsRepository repository;

  UpdateSettingsUseCase(this.repository);

  @override
  Future<void> call(UpdateSettingsParams params) async {
    final updatedSettings = params.settings.copyWith(
      lastUpdated: DateTime.now(),
    );
    await repository.updateSettings(updatedSettings);
  }
}
