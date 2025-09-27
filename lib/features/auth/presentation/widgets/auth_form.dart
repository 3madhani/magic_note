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
    final theme = Theme.of(context);

    InputDecoration decoration(String label, IconData icon) {
      return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: theme.colorScheme.onSurface.withOpacity(0.8),
        ),
        prefixIcon: Icon(
          icon,
          color: theme.colorScheme.onSurface.withOpacity(0.8),
        ),
        filled: true,
        fillColor: theme.colorScheme.onSurface.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.onSurface.withOpacity(0.2),
          ),
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
          child: AnimatedContainer(
            duration: 700.ms,
            curve: Curves.fastOutSlowIn,
            child: Column(
              key: ValueKey(isLogin),
              children: [
                AuthToggleButtons(isLogin: isLogin, onToggle: onToggle),
                const SizedBox(height: 32),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: theme.colorScheme.onSurface),
                  decoration: decoration("Email", Icons.email_outlined),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  style: TextStyle(color: theme.colorScheme.onSurface),
                  decoration: decoration("Password", Icons.lock_outline)
                      .copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                          onPressed: onTogglePassword,
                        ),
                      ),
                ),
                if (!isLogin) ...[
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: obscurePassword,
                    style: TextStyle(color: theme.colorScheme.onSurface),
                    decoration: decoration(
                      "Confirm Password",
                      Icons.lock_outline,
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                SubmitButton(
                  isLogin: isLogin,
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                const SizedBox(height: 24),
                DemoButton(),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 800.ms, delay: 700.ms)
        .slideY(begin: 0.3, duration: 800.ms);
  }
}
