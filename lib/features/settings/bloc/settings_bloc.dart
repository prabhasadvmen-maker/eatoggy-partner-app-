import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<LoadSettingsEvent>(_onLoadSettings);
    on<TogglePushNotificationsEvent>(_onTogglePushNotifications);
    on<ToggleSoundAlertsEvent>(_onToggleSoundAlerts);
    on<ToggleAutoAcceptDeliveriesEvent>(_onToggleAutoAcceptDeliveries);
    on<ChangeLanguageEvent>(_onChangeLanguage);
  }

  void _onLoadSettings(LoadSettingsEvent event, Emitter<SettingsState> emit) {
    emit(state.copyWith(status: SettingsStatus.loaded));
  }

  void _onTogglePushNotifications(
      TogglePushNotificationsEvent event, Emitter<SettingsState> emit) {
    emit(state.copyWith(
      settings: state.settings.copyWith(pushNotifications: event.value),
      message: 'Push notifications ${event.value ? 'enabled' : 'disabled'}',
    ));
  }

  void _onToggleSoundAlerts(
      ToggleSoundAlertsEvent event, Emitter<SettingsState> emit) {
    emit(state.copyWith(
      settings: state.settings.copyWith(soundAlerts: event.value),
      message: 'Sound alerts ${event.value ? 'enabled' : 'disabled'}',
    ));
  }

  void _onToggleAutoAcceptDeliveries(
      ToggleAutoAcceptDeliveriesEvent event, Emitter<SettingsState> emit) {
    emit(state.copyWith(
      settings: state.settings.copyWith(autoAcceptNextDeliveries: event.value),
      message:
          'Auto-accept deliveries ${event.value ? 'enabled' : 'disabled'}',
    ));
  }

  void _onChangeLanguage(
      ChangeLanguageEvent event, Emitter<SettingsState> emit) {
    emit(state.copyWith(
      settings: state.settings.copyWith(preferredLanguage: event.language),
      message: 'Language updated to ${event.language}',
    ));
  }
}
