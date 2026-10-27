import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class DeliverySuccessBadge extends StatelessWidget {
  const DeliverySuccessBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: AppColors.successLight,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.success.withValues(alpha: 0.3),
          width: 3.0,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.check_rounded,
          color: AppColors.successText,
          size: 48,
        ),
      ),
    );
  }
}
