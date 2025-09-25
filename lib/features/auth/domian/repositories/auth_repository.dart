import '../entities/user.dart';

abstract class AuthRepository {
  Future<bool> isAuthenticated();
  Future<User?> getCurrentUser();
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String name);
  Future<void> logout();
  Future<void> saveAuthState(bool isAuthenticated);
}
