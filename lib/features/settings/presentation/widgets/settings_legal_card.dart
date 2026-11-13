import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class SettingsLegalCard extends StatelessWidget {
  final VoidCallback onPrivacyTap;
  final VoidCallback onTermsTap;
  final VoidCallback onAboutTap;

  const SettingsLegalCard({
    super.key,
    required this.onPrivacyTap,
    required this.onTermsTap,
    required this.onAboutTap,
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
          _buildItem(
            title: 'Privacy Suite Policy',
            onTap: onPrivacyTap,
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.border),
          _buildItem(
            title: 'Terms of Logistics Service',
            onTap: onTermsTap,
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.border),
          _buildItem(
            title: 'About Eatoggy Premium',
            onTap: onAboutTap,
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.geist(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.1,
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
