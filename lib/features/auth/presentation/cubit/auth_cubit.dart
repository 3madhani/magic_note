import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domian/usecases/check_auth_usecase.dart';
import '../../domian/usecases/login_usecase.dart';
import '../../domian/usecases/logout_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckAuthUseCase checkAuthUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.checkAuthUseCase,
  }) : super(AuthInitial());

  Future<void> checkAuthStatus() async {
    try {
      emit(AuthLoading());
      final isAuthenticated = await checkAuthUseCase();
      if (isAuthenticated) {
        // For demo purposes, create a demo user
        // In a real app, you'd get the user from repository
        final user = await loginUseCase(
          LoginParams(email: 'demo@magicnotes.com', password: 'demo'),
        );
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> login({String? email, String? password}) async {
    try {
      emit(AuthLoading());
      final user = await loginUseCase(
        LoginParams(
          email: email ?? 'demo@magicnotes.com',
          password: password ?? 'demo',
        ),
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError('Login failed: ${e.toString()}'));
    }
  }

  Future<void> logout() async {
    try {
      await logoutUseCase();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Logout failed: ${e.toString()}'));
    }
  }
}
