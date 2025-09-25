abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

abstract class UseCaseNoParams<T> {
  Future<T> call();
}
