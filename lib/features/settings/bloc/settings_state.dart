import 'package:equatable/equatable.dart';
import '../data/models/settings_model.dart';

enum SettingsStatus { initial, loading, loaded, error }

class SettingsState extends Equatable {
  final SettingsStatus status;
  final SettingsModel settings;
  final String? message;

  const SettingsState({
    this.status = SettingsStatus.initial,
    this.settings = const SettingsModel(),
    this.message,
  });

  SettingsState copyWith({
    SettingsStatus? status,
    SettingsModel? settings,
    String? message,
  }) {
    return SettingsState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, settings, message];
}
