import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:magic_note/features/auth/presentation/widgets/auth_toggle_buttons.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../../../core/widgets/glass_container.dart';
import 'demo_button.dart';
import 'submit_button.dart';

class AuthForm extends StatelessWidget {
  final bool isLogin;
  final bool obscurePassword;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final ValueChanged<bool> onToggle;
  final VoidCallback onTogglePassword;

  const AuthForm({
    super.key,
    required this.isLogin,
    required this.obscurePassword,
    required this.emailController,
    required this.passwordController,
    required this.onToggle,
    required this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    InputDecoration decoration(String label, IconData icon) {
      return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
        prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.8)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: ThemeConstants.goldenColor,
            width: 2,
          ),
        ),
      );
    }

    return GlassContainer(
          padding: const EdgeInsets.all(32),
          child: AnimatedSize(
            duration: 500.ms,
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter, // يبدأ التمدد من فوق لتحت
            child: Column(
              key: ValueKey(isLogin), // علشان يتغير المحتوى
              mainAxisSize: MainAxisSize.min,
              children: [
                AuthToggleButtons(isLogin: isLogin, onToggle: onToggle),
                const SizedBox(height: 32),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: decoration("Email", Icons.email_outlined),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  style: TextStyle(color: Colors.white),
                  decoration: decoration("Password", Icons.lock_outline)
                      .copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white.withOpacity(0.7),
                          ),
                          onPressed: onTogglePassword,
                        ),
                      ),
                ),
                if (!isLogin) ...[
                  const SizedBox(height: 20),
                  SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: Offset(-1, 0),
                          end: Offset(0, 0),
                        ).animate(
                          CurvedAnimation(
                            parent: AnimationController(
                              duration: const Duration(milliseconds: 500),
                              vsync: Scaffold.of(context),
                            )..forward(),
                            curve: Curves.easeInOut,
                          ),
                        ),

                    child: !isLogin
                        ? TextFormField(
                            key: const ValueKey("confirmField"),
                            obscureText: obscurePassword,
                            style: TextStyle(color: Colors.white),
                            decoration: decoration(
                              "Confirm Password",
                              Icons.lock_outline,
                            ),
                          )
                        : const SizedBox.shrink(key: ValueKey("empty")),
                  ),
                ],
                const SizedBox(height: 32),
                SubmitButton(
                  isLogin: isLogin,
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                const SizedBox(height: 24),
                const DemoButton(),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 800.ms, delay: 700.ms)
        .slideY(begin: 0.3, duration: 800.ms);
  }
}
