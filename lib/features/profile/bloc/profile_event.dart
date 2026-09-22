import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfileEvent extends ProfileEvent {
  const LoadProfileEvent();
}

class EditProfileTappedEvent extends ProfileEvent {
  const EditProfileTappedEvent();
}

class LogoutProfileEvent extends ProfileEvent {
  const LogoutProfileEvent();
}

class ToggleSupportViewEvent extends ProfileEvent {
  final bool show;

  const ToggleSupportViewEvent(this.show);

  @override
  List<Object?> get props => [show];
}

class ToggleSettingsViewEvent extends ProfileEvent {
  final bool show;

  const ToggleSettingsViewEvent(this.show);

  @override
  List<Object?> get props => [show];
}
