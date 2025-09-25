import '../../../../core/usecases/usecase.dart';
import '../entities/settings.dart';
import '../repositories/settings_repository.dart';

class GetSettingsUseCase implements UseCaseNoParams<Settings> {
  final SettingsRepository repository;

  GetSettingsUseCase(this.repository);

  @override
  Future<Settings> call() async {
    return await repository.getSettings();
  }
}
