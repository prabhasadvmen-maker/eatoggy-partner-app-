import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        color: const Color(0xFF1A1A1C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF262628),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildItem(
            title: 'Privacy Suite Policy',
            onTap: onPrivacyTap,
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFF242426)),
          _buildItem(
            title: 'Terms of Logistics Service',
            onTap: onTermsTap,
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFF242426)),
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
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.1,
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF8E8E93),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
