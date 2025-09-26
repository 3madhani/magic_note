import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'features/app/cubit/app_cubit.dart';
import 'features/app/pages/app_page.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/notes/presentation/cubit/notes_cubit.dart';
import 'features/settings/presentation/cubit/settings_cubit.dart';
import 'features/settings/presentation/cubit/settings_state.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()..checkAuthStatus()),
        BlocProvider(create: (_) => di.sl<NotesCubit>()),
        BlocProvider(create: (_) => di.sl<SettingsCubit>()..loadSettings()),
        BlocProvider(create: (_) => AppCubit()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          bool isDarkMode = false;
          if (settingsState is SettingsLoaded) {
            isDarkMode = settingsState.settings.isDarkMode;
          }

          return MaterialApp(
            title: 'Magic Notes',
            debugShowCheckedModeBanner: false,

            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const AppPage(),
          ).animate().fadeIn(duration: 800.ms);
        },
      ),
    );
  }
}
