import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileMenuCard extends StatelessWidget {
  final VoidCallback onSupportTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onEmergencyTap;
  final VoidCallback onAboutTap;
  final VoidCallback onLogoutTap;

  const ProfileMenuCard({
    super.key,
    required this.onSupportTap,
    required this.onSettingsTap,
    required this.onEmergencyTap,
    required this.onAboutTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF262628),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.headphones_rounded,
            title: 'Support',
            iconColor: AppColors.cardGoldAccent,
            iconBg: const Color(0xFF231E14),
            textColor: Colors.white,
            onTap: onSupportTap,
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFF242426)),
          _buildMenuItem(
            icon: Icons.settings_rounded,
            title: 'Settings',
            iconColor: AppColors.cardGoldAccent,
            iconBg: const Color(0xFF231E14),
            textColor: Colors.white,
            onTap: onSettingsTap,
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFF242426)),
          _buildMenuItem(
            icon: Icons.warning_amber_rounded,
            title: 'Emergency Report',
            iconColor: AppColors.cardGoldAccent,
            iconBg: const Color(0xFF231E14),
            textColor: Colors.white,
            onTap: onEmergencyTap,
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFF242426)),
          _buildMenuItem(
            icon: Icons.info_outline_rounded,
            title: 'About EATOGGY',
            iconColor: AppColors.cardGoldAccent,
            iconBg: const Color(0xFF231E14),
            textColor: Colors.white,
            onTap: onAboutTap,
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFF242426)),
          _buildMenuItem(
            icon: Icons.logout_rounded,
            title: 'Logout',
            iconColor: const Color(0xFFE54D4D),
            iconBg: const Color(0xFF2A1616),
            textColor: const Color(0xFFE54D4D),
            onTap: onLogoutTap,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Color iconColor,
    required Color iconBg,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 20,
                  color: iconColor,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.1,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF6E6E73),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
