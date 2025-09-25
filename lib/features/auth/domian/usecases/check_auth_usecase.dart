import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class CheckAuthUseCase implements UseCaseNoParams<bool> {
  final AuthRepository repository;

  CheckAuthUseCase(this.repository);

  @override
  Future<bool> call() async {
    return await repository.isAuthenticated();
  }
}
