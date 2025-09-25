import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../core/errors/exceptions.dart';
import '../../notes/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<bool> isAuthenticated();
  Future<UserModel?> getCurrentUser();
  Future<void> saveAuthState(bool isAuthenticated);
  Future<void> saveUser(UserModel user);
  Future<void> clearUserData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> isAuthenticated() async {
    try {
      return sharedPreferences.getBool(AppConstants.authKey) ?? false;
    } catch (e) {
      throw CacheException('Failed to check auth state: $e');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final userJson = sharedPreferences.getString('currentUser');
      if (userJson != null) {
        return UserModel.fromJson(jsonDecode(userJson));
      }
      return null;
    } catch (e) {
      throw CacheException('Failed to get current user: $e');
    }
  }

  @override
  Future<void> saveAuthState(bool isAuthenticated) async {
    try {
      await sharedPreferences.setBool(AppConstants.authKey, isAuthenticated);
    } catch (e) {
      throw CacheException('Failed to save auth state: $e');
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      await sharedPreferences.setString(
        'currentUser',
        jsonEncode(user.toJson()),
      );
    } catch (e) {
      throw CacheException('Failed to save user: $e');
    }
  }

  @override
  Future<void> clearUserData() async {
    try {
      await sharedPreferences.remove('currentUser');
      await saveAuthState(false);
    } catch (e) {
      throw CacheException('Failed to clear user data: $e');
    }
  }
}
