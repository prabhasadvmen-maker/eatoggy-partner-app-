import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDetailsCard extends StatelessWidget {
  final String phoneNumber;
  final String vehicleDetails;
  final String preferredZone;

  const ProfileDetailsCard({
    super.key,
    required this.phoneNumber,
    required this.vehicleDetails,
    required this.preferredZone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
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
          _buildDetailRow('Phone Number', phoneNumber),
          const SizedBox(height: 14),
          _buildDetailRow('Vehicle Details', vehicleDetails),
          const SizedBox(height: 14),
          _buildDetailRow('Preferred Zone', preferredZone),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF8E8E93),
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                value,
                maxLines: 1,
                softWrap: false,
                textAlign: TextAlign.right,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
