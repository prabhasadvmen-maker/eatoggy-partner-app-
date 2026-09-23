import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettingsEvent extends SettingsEvent {
  const LoadSettingsEvent();
}

class TogglePushNotificationsEvent extends SettingsEvent {
  final bool value;

  const TogglePushNotificationsEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class ToggleSoundAlertsEvent extends SettingsEvent {
  final bool value;

  const ToggleSoundAlertsEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class ToggleAutoAcceptDeliveriesEvent extends SettingsEvent {
  final bool value;

  const ToggleAutoAcceptDeliveriesEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class ChangeLanguageEvent extends SettingsEvent {
  final String language;

  const ChangeLanguageEvent(this.language);

  @override
  List<Object?> get props => [language];
}
