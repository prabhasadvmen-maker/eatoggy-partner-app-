import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
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
    const bgColor = AppColors.darkBackground;
    const goldColor = AppColors.goldFont;
    const borderColor = AppColors.darkBorder;
    const cardBgColor = AppColors.darkSurface;

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
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1.h),

                // STEP 1 OF 3
                Text(
                  'STEP 1 OF 3',
                  style: AppTextStyles.label,
                ),
                SizedBox(height: 1.h),

                // Verify your identity
                Text(
                  'Verify your identity',
                  style: AppTextStyles.displayLarge,
                ),
                SizedBox(height: 1.h),

                // Subtitle
                Text(
                  'Upload clear copies of your government-issued documents. Your information stays encrypted and secure.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white70,
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
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: cardBgColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isUploaded ? AppColors.success : borderColor,
                            width: isUploaded ? 1.5 : 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.badge_outlined,
                                color: goldColor,
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
                                    style: AppTextStyles.titleMedium.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    isUploaded
                                        ? 'Front and back uploaded'
                                        : 'Tap to capture Aadhaar card (Camera)',
                                    style: AppTextStyles.caption.copyWith(
                                      color: isUploaded
                                          ? AppColors.success
                                          : Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: isUploaded
                                    ? AppColors.success
                                    : Colors.white.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isUploaded ? Icons.check : Icons.camera_alt_outlined,
                                color: isUploaded ? Colors.white : goldColor,
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
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: cardBgColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isUploaded ? AppColors.success : borderColor,
                            width: isUploaded ? 1.5 : 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.assignment_ind_outlined,
                                color: goldColor,
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
                                    style: AppTextStyles.titleMedium.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    isUploaded
                                        ? 'PAN card uploaded'
                                        : 'Tap to upload your PAN card',
                                    style: AppTextStyles.caption.copyWith(
                                      color: isUploaded
                                          ? AppColors.success
                                          : Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: isUploaded
                                    ? AppColors.success
                                    : Colors.white.withValues(alpha: 0.05),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isUploaded ? Icons.check : Icons.file_upload_outlined,
                                color: isUploaded ? Colors.white : goldColor,
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
                    color: goldColor.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: goldColor.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Before you upload',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: goldColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Make sure all four corners are visible and the details are clear.\nAccepted formats: JPG, PNG or PDF.',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white70,
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

                SizedBox(height: 4.h),

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
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white54,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 2.h),

                // Continue to Banking Button
                BlocBuilder<DocumentVerificationBloc, DocumentVerificationState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: state.isSubmitting
                          ? null
                          : () {
                              context.read<DocumentVerificationBloc>().add(
                                    const DocumentVerificationSubmitted(),
                                  );
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
                                  'Continue to Banking',
                                  style: AppTextStyles.button,
                                ),
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
