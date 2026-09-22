import 'package:equatable/equatable.dart';

class SettingsModel extends Equatable {
  final bool pushNotifications;
  final bool soundAlerts;
  final bool autoAcceptNextDeliveries;
  final String preferredLanguage;
  final String appVersion;
  final List<String> availableLanguages;

  const SettingsModel({
    this.pushNotifications = true,
    this.soundAlerts = true,
    this.autoAcceptNextDeliveries = false,
    this.preferredLanguage = 'English (US)',
    this.appVersion = 'v2.4.1 (Premium Luxury Suite)',
    this.availableLanguages = const [
      'English (US)',
      'Hindi (हिन्दी)',
      'Kannada (ಕನ್ನಡ)',
      'Tamil (தமிழ்)',
      'Telugu (తెలుగు)',
    ],
  });

  SettingsModel copyWith({
    bool? pushNotifications,
    bool? soundAlerts,
    bool? autoAcceptNextDeliveries,
    String? preferredLanguage,
    String? appVersion,
    List<String>? availableLanguages,
  }) {
    return SettingsModel(
      pushNotifications: pushNotifications ?? this.pushNotifications,
      soundAlerts: soundAlerts ?? this.soundAlerts,
      autoAcceptNextDeliveries:
          autoAcceptNextDeliveries ?? this.autoAcceptNextDeliveries,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      appVersion: appVersion ?? this.appVersion,
      availableLanguages: availableLanguages ?? this.availableLanguages,
    );
  }

  @override
  List<Object?> get props => [
        pushNotifications,
        soundAlerts,
        autoAcceptNextDeliveries,
        preferredLanguage,
        appVersion,
        availableLanguages,
      ];
}
