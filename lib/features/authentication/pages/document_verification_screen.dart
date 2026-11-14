import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/common_widgets.dart';
import '../bloc/document_verification_bloc.dart';

class DocumentVerificationScreen extends StatelessWidget {
  final VoidCallback onContinueToBanking;

  const DocumentVerificationScreen({
    super.key,
    required this.onContinueToBanking,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DocumentVerificationBloc(),
      child: DocumentVerificationView(
        onContinueToBanking: onContinueToBanking,
      ),
    );
  }
}

class DocumentVerificationView extends StatelessWidget {
  final VoidCallback onContinueToBanking;

  const DocumentVerificationView({
    super.key,
    required this.onContinueToBanking,
  });

  @override
  Widget build(BuildContext context) {
    const bgColor = AppColors.background;
    const borderColor = AppColors.border;
    const cardBgColor = AppColors.surface;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: BlocListener<DocumentVerificationBloc, DocumentVerificationState>(
          listener: (context, state) {
            if (state.isSuccess) {
              onContinueToBanking();
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1.h),

                // STEP 1 OF 3
                const StepIndicator(currentStep: 1, totalSteps: 3),
                SizedBox(height: 1.2.h),

                // Verify your identity
                Text(
                  'Verify your identity',
                  style: AppTextStyles.displayLarge,
                ),
                SizedBox(height: 1.2.h),

                // Subtitle
                Text(
                  'Upload clear copies of your government-issued documents. Your information stays encrypted and secure.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    height: 1.4,
                  ),
                ),

                SizedBox(height: 3.5.h),

                // Aadhaar Card Box
                BlocBuilder<DocumentVerificationBloc, DocumentVerificationState>(
                  builder: (context, state) {
                    final isUploaded = state.isAadhaarUploaded;
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<DocumentVerificationBloc>()
                            .add(const UploadAadhaarFromCamera());
                      },
                      child: Container(
                        padding: EdgeInsets.all(4.5.w),
                        decoration: BoxDecoration(
                          color: cardBgColor,
                          borderRadius: AppRadius.borderLg,
                          border: Border.all(
                            color: isUploaded ? AppColors.success : borderColor,
                            width: isUploaded ? 1.5 : 1.2,
                          ),
                          boxShadow: AppShadows.card,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: isUploaded
                                    ? AppColors.successLight
                                    : AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.badge_outlined,
                                color: isUploaded
                                    ? AppColors.success
                                    : AppColors.primary,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Aadhaar card',
                                    style: AppTextStyles.titleMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    isUploaded
                                        ? 'Front and back uploaded'
                                        : 'Tap to capture Aadhaar card (Camera)',
                                    style: AppTextStyles.caption.copyWith(
                                      color: isUploaded
                                          ? AppColors.successText
                                          : AppColors.textSecondary,
                                      fontWeight: isUploaded
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: isUploaded
                                    ? AppColors.success
                                    : AppColors.surfaceSubtle,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isUploaded ? Icons.check : Icons.camera_alt_outlined,
                                color: isUploaded ? Colors.white : AppColors.textSecondary,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 2.h),

                // PAN Card Box
                BlocBuilder<DocumentVerificationBloc, DocumentVerificationState>(
                  builder: (context, state) {
                    final isUploaded = state.isPanUploaded;
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<DocumentVerificationBloc>()
                            .add(const UploadPanFromCamera());
                      },
                      child: Container(
                        padding: EdgeInsets.all(4.5.w),
                        decoration: BoxDecoration(
                          color: cardBgColor,
                          borderRadius: AppRadius.borderLg,
                          border: Border.all(
                            color: isUploaded ? AppColors.success : borderColor,
                            width: isUploaded ? 1.5 : 1.2,
                          ),
                          boxShadow: AppShadows.card,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: isUploaded
                                    ? AppColors.successLight
                                    : AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.assignment_ind_outlined,
                                color: isUploaded
                                    ? AppColors.success
                                    : AppColors.primary,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PAN card',
                                    style: AppTextStyles.titleMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    isUploaded
                                        ? 'PAN card uploaded'
                                        : 'Tap to upload your PAN card',
                                    style: AppTextStyles.caption.copyWith(
                                      color: isUploaded
                                          ? AppColors.successText
                                          : AppColors.textSecondary,
                                      fontWeight: isUploaded
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: isUploaded
                                    ? AppColors.success
                                    : AppColors.surfaceSubtle,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isUploaded ? Icons.check : Icons.file_upload_outlined,
                                color: isUploaded ? Colors.white : AppColors.textSecondary,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 3.5.h),

                // Before you upload Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSubtle,
                    borderRadius: AppRadius.borderLg,
                    border: Border.all(
                      color: AppColors.border,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.info_outline_rounded,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Before you upload',
                            style: AppTextStyles.titleMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Make sure all four corners are visible and the details are clear.\nAccepted formats: JPG, PNG or PDF.',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 12.sp,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 2.h),

                // Error Message if any
                BlocBuilder<DocumentVerificationBloc, DocumentVerificationState>(
                  buildWhen: (p, c) => p.errorMessage != c.errorMessage,
                  builder: (context, state) {
                    if (state.errorMessage == null) return const SizedBox.shrink();
                    return Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: Text(
                        state.errorMessage!,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.error,
                          fontSize: 12.sp,
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 3.h),

                // Security note
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
                        'Documents are protected with bank-grade encryption',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 2.5.h),

                // Continue to Banking Button (Solid Crimson Red)
                BlocBuilder<DocumentVerificationBloc, DocumentVerificationState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppDimensions.buttonHeight,
                      child: ElevatedButton(
                        onPressed: state.isSubmitting
                            ? null
                            : () {
                                context.read<DocumentVerificationBloc>().add(
                                      const DocumentVerificationSubmitted(),
                                    );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.textLight,
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: AppRadius.borderLg,
                          ),
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
                                'Continue to Banking',
                                style: AppTextStyles.button,
                              ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
