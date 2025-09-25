import 'package:equatable/equatable.dart';

import '../../domain/entities/settings.dart';

class SettingsError extends SettingsState {
  final String message;

  const SettingsError(this.message);

  @override
  List<Object?> get props => [message];
}

class SettingsInitial extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final Settings settings;

  const SettingsLoaded(this.settings);

  @override
  List<Object?> get props => [settings];
}

class SettingsLoading extends SettingsState {}

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsUpdated extends SettingsState {
  final Settings settings;
  final String message;

  const SettingsUpdated(this.settings, this.message);

  @override
  List<Object?> get props => [settings, message];
}
