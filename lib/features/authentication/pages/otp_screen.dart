import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../bloc/otp_bloc.dart';

class OtpScreen extends StatelessWidget {
  final String phone;
  final VoidCallback onVerifySuccess;
  final VoidCallback onChangePhoneTap;

  const OtpScreen({
    super.key,
    required this.phone,
    required this.onVerifySuccess,
    required this.onChangePhoneTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpBloc(phone: phone),
      child: OtpView(
        onVerifySuccess: onVerifySuccess,
        onChangePhoneTap: onChangePhoneTap,
      ),
    );
  }
}

class OtpView extends StatefulWidget {
  final VoidCallback onVerifySuccess;
  final VoidCallback onChangePhoneTap;

  const OtpView({
    super.key,
    required this.onVerifySuccess,
    required this.onChangePhoneTap,
  });

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = AppColors.background;
    const borderColor = AppColors.border;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: BlocListener<OtpBloc, OtpState>(
          listener: (context, state) {
            if (state.isSuccess) {
              widget.onVerifySuccess();
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3.h),

                // Title & Subtitle using AppTextStyles
                Text(
                  'Partner Entrance',
                  style: AppTextStyles.displayLarge,
                ),
                SizedBox(height: 1.2.h),
                Text(
                  'Verify your mobile number',
                  style: AppTextStyles.bodyMedium,
                ),

                SizedBox(height: 4.h),

                // OTP SENT TO Label & Phone Row with Change action
                Text(
                  'OTP SENT TO',
                  style: AppTextStyles.label,
                ),
                SizedBox(height: 1.h),
                BlocBuilder<OtpBloc, OtpState>(
                  buildWhen: (p, c) => p.phone != c.phone,
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text('🇮🇳', style: TextStyle(fontSize: 18)),
                            const SizedBox(width: 8),
                            Text(
                              state.phone,
                              style: AppTextStyles.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: widget.onChangePhoneTap,
                          child: Text(
                            'Change',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 2.5.h),

                // Demo OTP Badge / Prompt Banner
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: AppRadius.borderMd,
                    border: Border.all(
                      color: AppColors.primaryBorder,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.mark_email_read_outlined,
                        color: AppColors.primary,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Text.rich(
                        TextSpan(
                          text: 'Your OTP Code is: ',
                          style: AppTextStyles.bodyMedium,
                          children: [
                            TextSpan(
                              text: '5214',
                              style: AppTextStyles.titleMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 3.h),

                // 4 OTP Boxes (Matches exact Figma reference)
                BlocBuilder<OtpBloc, OtpState>(
                  builder: (context, state) {
                    final hasError = state.otpError != null;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(4, (index) {
                            final isFocused = _focusNodes[index].hasFocus;
                            final hasValue = _controllers[index].text.isNotEmpty;
                            return Container(
                              width: 18.w,
                              height: 18.w,
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: AppRadius.borderLg,
                                border: Border.all(
                                  color: hasError
                                      ? AppColors.error
                                      : isFocused || hasValue
                                          ? AppColors.primary
                                          : borderColor,
                                  width: isFocused || hasError || hasValue ? 1.5 : 1.0,
                                ),
                                boxShadow: isFocused
                                    ? [
                                        BoxShadow(
                                          color: AppColors.primary.withValues(alpha: 0.15),
                                          blurRadius: 8,
                                          spreadRadius: 1,
                                        )
                                      ]
                                    : AppShadows.card,
                              ),
                              child: Center(
                                child: TextField(
                                  controller: _controllers[index],
                                  focusNode: _focusNodes[index],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.headingLarge.copyWith(
                                    color: AppColors.textPrimary,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(1),
                                  ],
                                  onChanged: (value) {
                                    context.read<OtpBloc>().add(OtpDigitChanged(index, value));
                                    if (value.isNotEmpty && index < 3) {
                                      _focusNodes[index + 1].requestFocus();
                                    } else if (value.isEmpty && index > 0) {
                                      _focusNodes[index - 1].requestFocus();
                                    }
                                    setState(() {});
                                  },
                                  decoration: const InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: false,
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        if (hasError) ...[
                          SizedBox(height: 1.2.h),
                          Text(
                            state.otpError!,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.error,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),

                SizedBox(height: 3.h),

                // Resend OTP in 00:28 ... Resend Row
                BlocBuilder<OtpBloc, OtpState>(
                  builder: (context, state) {
                    final timerStr = '00:${state.timerSeconds.toString().padLeft(2, '0')}';
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'Resend OTP in ',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            children: [
                              TextSpan(
                                text: timerStr,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: state.canResend
                              ? () {
                                  for (var c in _controllers) {
                                    c.clear();
                                  }
                                  context.read<OtpBloc>().add(const OtpResendRequested());
                                }
                              : null,
                          child: Text(
                            'Resend',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: state.canResend ? AppColors.primary : AppColors.textMuted,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 4.h),

                // Verify & Continue Button
                BlocBuilder<OtpBloc, OtpState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppDimensions.buttonHeight,
                      child: ElevatedButton(
                        onPressed: state.isSubmitting
                            ? null
                            : () {
                                for (int i = 0; i < 4; i++) {
                                  context.read<OtpBloc>().add(OtpDigitChanged(i, _controllers[i].text));
                                }
                                context.read<OtpBloc>().add(const OtpSubmitted());
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.textLight,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
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
                                'Verify & Continue',
                                style: AppTextStyles.button,
                              ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 4.h),
                const Divider(color: borderColor, height: 1),
                SizedBox(height: 3.h),

                // Terms of Service & Privacy Policy Footer
                Center(
                  child: Column(
                    children: [
                      Text(
                        "By proceeding, you agree to EATOGGY's",
                        style: AppTextStyles.caption,
                      ),
                      SizedBox(height: 0.4.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Terms of Service',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textPrimary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            ' & ',
                            style: AppTextStyles.caption,
                          ),
                          Text(
                            'Privacy Policy',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textPrimary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
