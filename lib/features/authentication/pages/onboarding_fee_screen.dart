import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../bloc/onboarding_fee_bloc.dart';

class OnboardingFeeScreen extends StatelessWidget {
  final VoidCallback onPaymentSuccess;

  const OnboardingFeeScreen({
    super.key,
    required this.onPaymentSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingFeeBloc(),
      child: OnboardingFeeView(
        onPaymentSuccess: onPaymentSuccess,
      ),
    );
  }
}

class OnboardingFeeView extends StatelessWidget {
  final VoidCallback onPaymentSuccess;

  const OnboardingFeeView({
    super.key,
    required this.onPaymentSuccess,
  });

  @override
  Widget build(BuildContext context) {
    const bgColor = AppColors.darkBackground;
    const goldColor = AppColors.goldFont;
    const borderColor = AppColors.darkBorder;
    const cardBgColor = AppColors.darkSurface;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: BlocListener<OnboardingFeeBloc, OnboardingFeeState>(
          listener: (context, state) {
            if (state.isSuccess) {
              onPaymentSuccess();
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1.h),

                // STEP 3 OF 3
                Text(
                  'STEP 3 OF 3',
                  style: AppTextStyles.label,
                ),
                SizedBox(height: 1.h),

                // Complete onboarding
                Text(
                  'Complete onboarding',
                  style: AppTextStyles.displayLarge,
                ),
                SizedBox(height: 1.h),

                // Subtitle
                Text(
                  'A one-time onboarding fee activates your partner account and unlocks all earning tools.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),

                SizedBox(height: 3.5.h),

                // Fee Details Card Container
                Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row with ONE-TIME FEE & Lock Circle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ONE-TIME FEE',
                                style: AppTextStyles.caption.copyWith(
                                  color: goldColor,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  fontSize: 11.sp,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '₹499',
                                style: AppTextStyles.displayLarge.copyWith(
                                  color: Colors.white,
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.lock_outline_rounded,
                              color: goldColor,
                              size: 22,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 2.5.h),
                      Divider(color: borderColor.withValues(alpha: 0.6), height: 1),
                      SizedBox(height: 2.5.h),

                      // Breakdown Item 1: Partner onboarding
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Partner onboarding',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                          Text(
                            '₹499',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 1.5.h),

                      // Breakdown Item 2: GST included
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'GST included',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white54,
                            ),
                          ),
                          Text(
                            '₹0 extra',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 2.5.h),
                      Divider(color: borderColor.withValues(alpha: 0.6), height: 1),
                      SizedBox(height: 2.5.h),

                      // Total Payable Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total payable',
                            style: AppTextStyles.titleMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '₹499',
                            style: AppTextStyles.titleMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 3.5.h),

                // Bullet Benefits List
                _buildBenefitItem('Lifetime partner account'),
                SizedBox(height: 1.5.h),
                _buildBenefitItem('Instant payout access'),
                SizedBox(height: 1.5.h),
                _buildBenefitItem('Dedicated partner support'),

                SizedBox(height: 6.h),

                // Secure payment badge
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.shield_outlined,
                        color: AppColors.success,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Secure payment powered by trusted payment partners',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white54,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 2.h),

                // Pay ₹499 & Complete Button
                BlocBuilder<OnboardingFeeBloc, OnboardingFeeState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: state.isSubmitting
                          ? null
                          : () {
                              context.read<OnboardingFeeBloc>().add(const PaymentSubmitted());
                            },
                      child: Container(
                        height: 54,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: const LinearGradient(
                            colors: [AppColors.goldGradientStart, AppColors.goldGradientEnd],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: goldColor.withValues(alpha: 0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Center(
                          child: state.isSubmitting
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: AppColors.darkBackground,
                                  ),
                                )
                              : Text(
                                  'Pay ₹499 & Complete',
                                  style: AppTextStyles.button,
                                ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 2.h),

                // Terms & Privacy Notice
                Center(
                  child: Text(
                    "By continuing, you agree to EATOGGY's Terms of Service & Privacy Policy.",
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white38,
                      fontSize: 11.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem(String title) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: AppColors.success,
            size: 15,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: AppTextStyles.bodyLarge.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
