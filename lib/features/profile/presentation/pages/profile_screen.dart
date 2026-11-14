import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/profile_event.dart';
import '../../bloc/profile_state.dart';
import '../widgets/profile_stat_card.dart';
import '../widgets/profile_details_card.dart';
import '../widgets/profile_menu_card.dart';
import '../../../support/presentation/pages/support_screen.dart';
import '../../../settings/presentation/pages/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback onLogout;

  const ProfileScreen({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(const LoadProfileEvent()),
      child: ProfileView(onLogout: onLogout),
    );
  }
}

class ProfileView extends StatelessWidget {
  final VoidCallback onLogout;

  const ProfileView({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.showSupport) {
          return SupportScreen(
            onBack: () => context
                .read<ProfileBloc>()
                .add(const ToggleSupportViewEvent(false)),
          );
        }

        if (state.showSettings) {
          return SettingsScreen(
            onBack: () => context
                .read<ProfileBloc>()
                .add(const ToggleSettingsViewEvent(false)),
            onLogout: onLogout,
          );
        }

        final profile = state.profile;

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),

                  // Top Profile Avatar with Crimson Border (d16-profile.svg)
                  Center(
                    child: Container(
                      width: 98,
                      height: 98,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary,
                          width: 2.2,
                        ),
                      ),
                      padding: const EdgeInsets.all(3),
                      child: ClipOval(
                        child: Image.asset(
                          profile.avatarPath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: const Color(0xFFFEE2E2),
                            child: Center(
                              child: Text(
                                profile.name.isNotEmpty ? profile.name[0] : 'K',
                                style: GoogleFonts.fraunces(
                                  color: AppColors.primary,
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Partner Name (Fraunces Deep Stone Serif)
                  Text(
                    profile.name,
                    style: GoogleFonts.fraunces(
                      color: AppColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Partner ID
                  Text(
                    'Partner ID: ${profile.partnerId}',
                    style: GoogleFonts.geist(
                      color: AppColors.textSecondary,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // "VERIFIED PARTNER" Rose Outlined Pill Badge
                  if (profile.isVerified)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE4E8),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: const Color(0xFFFECACA),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'VERIFIED PARTNER',
                        style: GoogleFonts.geist(
                          color: AppColors.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  const SizedBox(height: 22),

                  // Stats Row: Rating, Deliveries, Member Since (Tap to open Scorecard)
                  GestureDetector(
                    onTap: () => context.push(AppRoutes.performanceScorecard),
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: Row(
                        children: [
                          ProfileStatCard(
                            label: 'Rating',
                            value: '${profile.rating} ★',
                            isHighlightValue: true,
                          ),
                          const SizedBox(width: 10),
                          ProfileStatCard(
                            label: 'Deliveries',
                            value: '${profile.totalDeliveries} Total',
                          ),
                          const SizedBox(width: 10),
                          ProfileStatCard(
                            label: 'Member Since',
                            value: profile.memberSince,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Partner Details Card (Phone, Vehicle, Preferred Zone)
                  ProfileDetailsCard(
                    phoneNumber: profile.phoneNumber,
                    vehicleDetails: profile.vehicleDetails,
                    preferredZone: profile.preferredZone,
                  ),
                  const SizedBox(height: 18),

                  // "Edit Profile" Primary Crimson CTA Button
                  GestureDetector(
                    onTap: () {
                      context
                          .read<ProfileBloc>()
                          .add(const EditProfileTappedEvent());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Edit Profile coming soon!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Edit Profile',
                          style: GoogleFonts.geist(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Settings & Options Menu Card (Support, Settings, Scorecard, Emergency, About, Logout)
                  ProfileMenuCard(
                    onSupportTap: () {
                      context
                          .read<ProfileBloc>()
                          .add(const ToggleSupportViewEvent(true));
                    },
                    onSettingsTap: () {
                      context
                          .read<ProfileBloc>()
                          .add(const ToggleSettingsViewEvent(true));
                    },
                    onPerformanceTap: () =>
                        context.push(AppRoutes.performanceScorecard),
                    onEmergencyTap: () =>
                        context.push(AppRoutes.sosEmergency),
                    onAboutTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('About EATOGGY v1.0.0')),
                      );
                    },
                    onLogoutTap: () => _showLogoutConfirmation(context),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
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
          'Logout',
          style: GoogleFonts.fraunces(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to log out of your partner account?',
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
