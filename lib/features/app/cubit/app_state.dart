import 'package:equatable/equatable.dart';

enum AppScreen { auth, home, update, settings, create }

class AppState extends Equatable {
  final AppScreen currentScreen;
  final bool isReminderModalOpen;

  const AppState({
    this.currentScreen = AppScreen.auth,
    this.isReminderModalOpen = false,
  });

  @override
  List<Object> get props => [currentScreen, isReminderModalOpen];

  AppState copyWith({AppScreen? currentScreen, bool? isReminderModalOpen}) {
    return AppState(
      currentScreen: currentScreen ?? this.currentScreen,
      isReminderModalOpen: isReminderModalOpen ?? this.isReminderModalOpen,
    );
  }
}
