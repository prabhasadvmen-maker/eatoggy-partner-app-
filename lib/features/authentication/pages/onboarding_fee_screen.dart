import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/common_widgets.dart';
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
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
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
                const StepIndicator(currentStep: 3, totalSteps: 3),
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
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),

                SizedBox(height: 3.5.h),

                // Fee Details Card Container
                AppCard(
                  padding: EdgeInsets.all(5.w),
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
                                style: AppTextStyles.label.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  fontSize: 11.sp,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '₹499',
                                style: AppTextStyles.displayLarge.copyWith(
                                  color: AppColors.textPrimary,
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
                              color: AppColors.surfaceSubtle,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.border),
                            ),
                            child: const Icon(
                              Icons.lock_outline_rounded,
                              color: AppColors.textPrimary,
                              size: 22,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 2.5.h),
                      const Divider(color: AppColors.border, height: 1),
                      SizedBox(height: 2.5.h),

                      // Breakdown Item 1: Partner onboarding
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Partner onboarding',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '₹499',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.textPrimary,
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
                              color: AppColors.textSecondary,
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
                      const Divider(color: AppColors.border, height: 1),
                      SizedBox(height: 2.5.h),

                      // Total Payable Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total payable',
                            style: AppTextStyles.titleMedium.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '₹499',
                            style: AppTextStyles.titleMedium.copyWith(
                              color: AppColors.primary,
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

                SizedBox(height: 5.h),

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
                          color: AppColors.textSecondary,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 2.h),

                // Pay ₹499 & Complete Button
                BlocBuilder<OnboardingFeeBloc, OnboardingFeeState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: state.isSubmitting
                            ? null
                            : () {
                                context
                                    .read<OnboardingFeeBloc>()
                                    .add(const PaymentSubmitted());
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: AppRadius.borderLg,
                          ),
                          elevation: 0,
                        ),
                        child: state.isSubmitting
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Pay ₹499 & Complete',
                                style: AppTextStyles.button.copyWith(
                                  color: Colors.white,
                                  fontSize: 14.sp,
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
                      color: AppColors.textTertiary,
                      fontSize: 10.sp,
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
            color: AppColors.successLight,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: AppColors.successText,
            size: 15,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textPrimary,
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }
}
