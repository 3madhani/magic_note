import '../../domian/entities/user.dart';
import '../../domian/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<User?> getCurrentUser() async {
    final userModel = await localDataSource.getCurrentUser();
    return userModel?.toEntity();
  }

  @override
  Future<bool> isAuthenticated() async {
    return await localDataSource.isAuthenticated();
  }

  @override
  Future<User> login(String email, String password) async {
    // For demo purposes, we'll create a demo user
    // In a real app, this would validate credentials with a server
    final user = UserModel.createDemo();
    await localDataSource.saveUser(user);
    return user.toEntity();
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearUserData();
  }

  @override
  Future<User> register(String email, String password, String name) async {
    // For demo purposes, create a new user
    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
    );

    await localDataSource.saveUser(user);
    return user.toEntity();
  }

  @override
  Future<void> saveAuthState(bool isAuthenticated) async {
    await localDataSource.saveAuthState(isAuthenticated);
  }
}
