import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  void closeReminderModal() {
    emit(state.copyWith(isReminderModalOpen: false));
  }

  void navigateToScreen(AppScreen screen) {
    emit(state.copyWith(currentScreen: screen));
  }

  void openReminderModal() {
    emit(state.copyWith(isReminderModalOpen: true));
  }
}
