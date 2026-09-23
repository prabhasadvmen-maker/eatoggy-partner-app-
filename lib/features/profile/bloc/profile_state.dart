import 'package:equatable/equatable.dart';
import '../data/models/profile_model.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final PartnerProfileModel profile;
  final bool showSupport;
  final bool showSettings;
  final String? message;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile = PartnerProfileModel.defaultProfile,
    this.showSupport = false,
    this.showSettings = false,
    this.message,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    PartnerProfileModel? profile,
    bool? showSupport,
    bool? showSettings,
    String? message,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      showSupport: showSupport ?? this.showSupport,
      showSettings: showSettings ?? this.showSettings,
      message: message,
    );
  }

  @override
  List<Object?> get props =>
      [status, profile, showSupport, showSettings, message];
}
