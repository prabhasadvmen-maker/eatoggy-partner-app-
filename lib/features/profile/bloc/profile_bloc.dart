import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import '../data/models/profile_model.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<EditProfileTappedEvent>(_onEditProfileTapped);
    on<LogoutProfileEvent>(_onLogoutProfile);
    on<ToggleSupportViewEvent>(_onToggleSupportView);
    on<ToggleSettingsViewEvent>(_onToggleSettingsView);
  }

  void _onToggleSettingsView(
      ToggleSettingsViewEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(showSettings: event.show));
  }

  void _onToggleSupportView(
      ToggleSupportViewEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(showSupport: event.show));
  }

  void _onLoadProfile(LoadProfileEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      status: ProfileStatus.loaded,
      profile: PartnerProfileModel.defaultProfile,
    ));
  }

  void _onEditProfileTapped(
      EditProfileTappedEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(message: 'Edit Profile clicked'));
  }

  void _onLogoutProfile(LogoutProfileEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(message: 'Logout initiated'));
  }
}
