import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../../notes/presentation/cubits/note_cubit/notes_cubit.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/animated_background.dart';
import '../widgets/auth_form.dart';
import '../widgets/magical_header.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;
  bool _obscurePassword = true;

  late AnimationController _floatingController;
  late AnimationController _rotationController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.read<NotesCubit>().addSampleNotes();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Welcome to Magic Notes!'),
              backgroundColor: ThemeConstants.goldenColor,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: theme.colorScheme.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDarkMode
                  ? [
                      ThemeConstants.darkBackground.withOpacity(0.6),
                      ThemeConstants.darkBackground,
                    ]
                  : [const Color(0xFF667eea), const Color(0xFF764ba2)],
            ),
          ),

          child: Stack(
            children: [
              AnimatedBackground(
                floatingController: _floatingController,
                rotationController: _rotationController,
              ),
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      const MagicalHeader(),
                      const SizedBox(height: 60),
                      AuthForm(
                        isLogin: _isLogin,
                        obscurePassword: _obscurePassword,
                        emailController: _emailController,
                        passwordController: _passwordController,
                        onToggle: (value) => setState(() => _isLogin = value),
                        onTogglePassword: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _floatingController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }
}
