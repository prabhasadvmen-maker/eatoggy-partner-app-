import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileMenuCard extends StatelessWidget {
  final VoidCallback onSupportTap;
  final VoidCallback onSettingsTap;
  final VoidCallback? onPerformanceTap;
  final VoidCallback onEmergencyTap;
  final VoidCallback onAboutTap;
  final VoidCallback onLogoutTap;

  const ProfileMenuCard({
    super.key,
    required this.onSupportTap,
    required this.onSettingsTap,
    this.onPerformanceTap,
    required this.onEmergencyTap,
    required this.onAboutTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.headphones_rounded,
            title: 'Support',
            iconColor: AppColors.primary,
            iconBg: const Color(0xFFFFF1F2),
            textColor: AppColors.textPrimary,
            onTap: onSupportTap,
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.border),
          _buildMenuItem(
            icon: Icons.settings_rounded,
            title: 'Settings',
            iconColor: AppColors.primary,
            iconBg: const Color(0xFFFFF1F2),
            textColor: AppColors.textPrimary,
            onTap: onSettingsTap,
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.border),
          if (onPerformanceTap != null) ...[
            _buildMenuItem(
              icon: Icons.military_tech_rounded,
              title: 'Performance Scorecard & Tier',
              iconColor: const Color(0xFFD97706),
              iconBg: const Color(0xFFFEF3C7),
              textColor: AppColors.textPrimary,
              onTap: onPerformanceTap!,
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.border),
          ],
          _buildMenuItem(
            icon: Icons.warning_amber_rounded,
            title: 'Emergency Report',
            iconColor: const Color(0xFFD97706),
            iconBg: const Color(0xFFFEF3C7),
            textColor: AppColors.textPrimary,
            onTap: onEmergencyTap,
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.border),
          _buildMenuItem(
            icon: Icons.info_outline_rounded,
            title: 'About EATOGGY',
            iconColor: AppColors.textSecondary,
            iconBg: const Color(0xFFF5F5F4),
            textColor: AppColors.textPrimary,
            onTap: onAboutTap,
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.border),
          _buildMenuItem(
            icon: Icons.logout_rounded,
            title: 'Logout',
            iconColor: const Color(0xFFDC2626),
            iconBg: const Color(0xFFFFF1F2),
            textColor: const Color(0xFFDC2626),
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
                style: GoogleFonts.geist(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.1,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textMuted,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
