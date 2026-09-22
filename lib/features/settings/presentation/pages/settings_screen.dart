import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/settings_bloc.dart';
import '../../bloc/settings_event.dart';
import '../../bloc/settings_state.dart';
import '../widgets/setting_toggle_card.dart';
import '../widgets/setting_dropdown_card.dart';
import '../widgets/settings_legal_card.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onLogout;

  const SettingsScreen({
    super.key,
    required this.onBack,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc()..add(const LoadSettingsEvent()),
      child: SettingsView(onBack: onBack, onLogout: onLogout),
    );
  }
}

class SettingsView extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onLogout;

  const SettingsView({
    super.key,
    required this.onBack,
    required this.onLogout,
  });

  static const Color _screenBg = Color(0xFF111111);
  static const Color _goldColor = Color(0xFFE5A64E);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          onBack();
        }
      },
      child: Scaffold(
        backgroundColor: _screenBg,
        body: BlocConsumer<SettingsBloc, SettingsState>(
          listener: (context, state) {
            if (state.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          builder: (context, state) {
            final settings = state.settings;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // Top Header Row with Circular Back Arrow Button
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onBack,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A1C),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF262628),
                              width: 1,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: _goldColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Screen Title (Fraunces Warm Cream Serif)
                  Text(
                    'Settings',
                    style: GoogleFonts.fraunces(
                      color: AppColors.creamText,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Toggle Option 1: Push Notifications
                  SettingToggleCard(
                    title: 'Push Notifications',
                    value: settings.pushNotifications,
                    onChanged: (val) {
                      context
                          .read<SettingsBloc>()
                          .add(TogglePushNotificationsEvent(val));
                    },
                  ),

                  // Toggle Option 2: Sound Alerts & Alarms
                  SettingToggleCard(
                    title: 'Sound Alerts & Alarms',
                    value: settings.soundAlerts,
                    onChanged: (val) {
                      context
                          .read<SettingsBloc>()
                          .add(ToggleSoundAlertsEvent(val));
                    },
                  ),

                  // Toggle Option 3: Auto-Accept Next Deliveries
                  SettingToggleCard(
                    title: 'Auto-Accept Next Deliveries',
                    value: settings.autoAcceptNextDeliveries,
                    onChanged: (val) {
                      context
                          .read<SettingsBloc>()
                          .add(ToggleAutoAcceptDeliveriesEvent(val));
                    },
                  ),
                  const SizedBox(height: 14),

                  // Preferred Language Section
                  SettingDropdownCard(
                    selectedLanguage: settings.preferredLanguage,
                    availableLanguages: settings.availableLanguages,
                    onLanguageSelected: (lang) {
                      context
                          .read<SettingsBloc>()
                          .add(ChangeLanguageEvent(lang));
                    },
                  ),
                  const SizedBox(height: 20),

                  // Legal & Info Grouped Card
                  SettingsLegalCard(
                    onPrivacyTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Privacy Suite Policy details'),
                        ),
                      );
                    },
                    onTermsTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Terms of Logistics Service details'),
                        ),
                      );
                    },
                    onAboutTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('About Eatoggy Premium details'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 22),

                  // Version Text
                  Center(
                    child: Text(
                      settings.appVersion,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF6E6E73),
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Logout Partner Suite Red Outlined Button
                  InkWell(
                    onTap: () => _showLogoutConfirmation(context),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1314),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFE54D4D),
                          width: 1.2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Logout Partner Suite',
                          style: GoogleFonts.inter(
                            color: const Color(0xFFE54D4D),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: Color(0xFF262628)),
        ),
        title: Text(
          'Logout Partner Suite',
          style: GoogleFonts.fraunces(
            color: AppColors.creamText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to log out of your partner suite?',
          style: GoogleFonts.inter(
            color: const Color(0xFF8E8E93),
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: const Color(0xFF8E8E93),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE54D4D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              onLogout();
            },
            child: Text(
              'Logout',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
