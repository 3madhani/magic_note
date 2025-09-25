import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Features
import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domian/repositories/auth_repository.dart';
import 'features/auth/domian/usecases/check_auth_usecase.dart';
import 'features/auth/domian/usecases/login_usecase.dart';
import 'features/auth/domian/usecases/logout_usecase.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/notes/data/datasources/notes_local_data_source.dart';
import 'features/notes/data/repositories/notes_repository_impl.dart';
import 'features/notes/domain/repositories/notes_repository.dart';
import 'features/notes/domain/usecases/create_note_usecase.dart';
import 'features/notes/domain/usecases/delete_note_usecase.dart';
import 'features/notes/domain/usecases/get_notes_usecase.dart';
import 'features/notes/domain/usecases/search_notes_usecase.dart';
import 'features/notes/domain/usecases/update_note_usecase.dart';
import 'features/notes/presentation/cubit/notes_cubit.dart';
import 'features/settings/data/datasources/settings_local_data_source.dart';
import 'features/settings/data/repositories/settings_repository_impl.dart';
import 'features/settings/domain/repositories/settings_repository.dart';
import 'features/settings/domain/usecases/get_settings_usecase.dart';
import 'features/settings/domain/usecases/update_settings_usecase.dart';
import 'features/settings/presentation/cubit/settings_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features

  // Auth Feature
  _initAuth();

  // Notes Feature
  _initNotes();

  // Settings Feature
  _initSettings();

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}

void _initAuth() {
  // Cubit
  sl.registerFactory(
    () => AuthCubit(
      loginUseCase: sl(),
      logoutUseCase: sl(),
      checkAuthUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );
}

void _initNotes() {
  // Cubit
  sl.registerFactory(
    () => NotesCubit(
      getNotesUseCase: sl(),
      createNoteUseCase: sl(),
      updateNoteUseCase: sl(),
      deleteNoteUseCase: sl(),
      searchNotesUseCase: sl(),
      localDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetNotesUseCase(sl()));
  sl.registerLazySingleton(() => CreateNoteUseCase(sl()));
  sl.registerLazySingleton(() => UpdateNoteUseCase(sl()));
  sl.registerLazySingleton(() => DeleteNoteUseCase(sl()));
  sl.registerLazySingleton(() => SearchNotesUseCase(sl()));

  // Repository
  sl.registerLazySingleton<NotesRepository>(
    () => NotesRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<NotesLocalDataSource>(
    () => NotesLocalDataSourceImpl(sharedPreferences: sl()),
  );
}

void _initSettings() {
  // Cubit
  sl.registerFactory(
    () => SettingsCubit(getSettingsUseCase: sl(), updateSettingsUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetSettingsUseCase(sl()));
  sl.registerLazySingleton(() => UpdateSettingsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(sharedPreferences: sl()),
  );
}
