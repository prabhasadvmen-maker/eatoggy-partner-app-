import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/router/app_routes.dart';
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
        backgroundColor: AppColors.scaffoldBackground,
        body: SafeArea(
          child: BlocConsumer<SettingsBloc, SettingsState>(
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),

                    // Top Header Row with Circular Back Arrow Button
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onBack,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.border,
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: AppColors.textPrimary,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Screen Title (Fraunces Warm Serif)
                    Text(
                      'Settings',
                      style: GoogleFonts.fraunces(
                        color: AppColors.textPrimary,
                        fontSize: 26,
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

                    // Battery & Background Whitelist Card (Screen #7: BatteryOptimizationGuideScreen)
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => context.push(AppRoutes.batteryGuide),
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFEF3C7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.battery_charging_full_rounded,
                                    color: Color(0xFFD97706),
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Battery Whitelisting',
                                            style: GoogleFonts.geist(
                                              color: AppColors.textPrimary,
                                              fontSize: 14.5,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFD97706)
                                                  .withValues(alpha: 0.12),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              'CRITICAL',
                                              style: GoogleFonts.geist(
                                                color: const Color(0xFFD97706),
                                                fontSize: 9.5,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Step-by-step OEM guide for Samsung, Xiaomi, Vivo, Pixel',
                                        style: GoogleFonts.geist(
                                          color: AppColors.textSecondary,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right_rounded,
                                  color: AppColors.textMuted,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

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
                        style: GoogleFonts.geist(
                          color: AppColors.textSecondary,
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
                          color: const Color(0xFFFFF1F2),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFFECACA),
                            width: 1.2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Logout Partner Suite',
                            style: GoogleFonts.geist(
                              color: AppColors.primary,
                              fontSize: 15.5,
                              fontWeight: FontWeight.w600,
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
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.border),
        ),
        title: Text(
          'Logout Partner Suite',
          style: GoogleFonts.fraunces(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to log out of your partner suite?',
          style: GoogleFonts.geist(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: GoogleFonts.geist(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
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
              style: GoogleFonts.geist(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
