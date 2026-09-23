import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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

  static const Color _screenBg = Color(0xFF111111);
  static const Color _goldColor = Color(0xFFE5A64E);

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
          backgroundColor: _screenBg,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),

                // Top Profile Avatar with Gold Border
                Center(
                  child: Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _goldColor,
                        width: 2.2,
                      ),
                    ),
                    padding: const EdgeInsets.all(2.5),
                    child: ClipOval(
                      child: Image.asset(
                        profile.avatarPath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: const Color(0xFF707C54),
                          child: Center(
                            child: Text(
                              profile.name.isNotEmpty ? profile.name[0] : 'K',
                              style: GoogleFonts.fraunces(
                                color: Colors.white,
                                fontSize: 36,
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

                // Partner Name (Fraunces Warm Cream Serif)
                Text(
                  profile.name,
                  style: GoogleFonts.fraunces(
                    color: AppColors.creamText,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 4),

                // Partner ID (Muted Grey Sans-serif)
                Text(
                  'Partner ID: ${profile.partnerId}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF8E8E93),
                    fontSize: 13.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),

                // "VERIFIED PARTNER" Gold Outlined Pill Badge
                if (profile.isVerified)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _goldColor,
                        width: 1.2,
                      ),
                    ),
                    child: Text(
                      'VERIFIED PARTNER',
                      style: GoogleFonts.inter(
                        color: _goldColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                const SizedBox(height: 22),

                // Stats Row: Rating, Deliveries, Member Since
                Row(
                  children: [
                    ProfileStatCard(
                      label: 'Rating',
                      value: profile.rating,
                      isGoldValue: true,
                    ),
                    const SizedBox(width: 10),
                    ProfileStatCard(
                      label: 'Deliveries',
                      value: profile.totalDeliveries,
                    ),
                    const SizedBox(width: 10),
                    ProfileStatCard(
                      label: 'Member Since',
                      value: profile.memberSince,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Partner Details Card (Phone, Vehicle, Preferred Zone)
                ProfileDetailsCard(
                  phoneNumber: profile.phoneNumber,
                  vehicleDetails: profile.vehicleDetails,
                  preferredZone: profile.preferredZone,
                ),
                const SizedBox(height: 18),

                // "Edit Profile" Primary Gold CTA Button
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
                      color: _goldColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: _goldColor.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Edit Profile',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF161106),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // Settings & Options Menu Card (Support, Settings, Emergency, About, Logout)
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
                  onEmergencyTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Emergency Reporting coming soon!')),
                    );
                  },
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
        );
      },
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
          'Logout',
          style: GoogleFonts.fraunces(
            color: AppColors.creamText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to log out of your partner account?',
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
