import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback onLoginSuccess;
  final ValueChanged<String> onRequestOtp;

  const LoginScreen({
    super.key,
    required this.onLoginSuccess,
    required this.onRequestOtp,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: LoginView(
        onLoginSuccess: onLoginSuccess,
        onRequestOtp: onRequestOtp,
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  final VoidCallback onLoginSuccess;
  final ValueChanged<String> onRequestOtp;

  const LoginView({
    super.key,
    required this.onLoginSuccess,
    required this.onRequestOtp,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final state = context.read<LoginBloc>().state;
    _phoneController = TextEditingController(text: state.phone);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = AppColors.darkBackground;
    const goldColor = AppColors.goldFont;
    // const inputBgColor = AppColors.darkSurface;
    const borderColor = AppColors.darkBorder;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              final formattedPhone = state.phone.startsWith('+91')
                  ? state.phone
                  : '+91 ${state.phone.trim()}';
              widget.onRequestOtp(formattedPhone);
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),

                // Title & Subtitle using AppTextStyles
                Text(
                  'Partner Entrance',
                  style: AppTextStyles.displayLarge,
                ),
                SizedBox(height: 1.h),
                Text(
                  'Access the delivery suite and manage your schedules',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white70,
                  ),
                ),

                SizedBox(height: 4.h),

                // ENTER MOBILE NUMBER Label
                Text(
                  'ENTER MOBILE NUMBER',
                  style: AppTextStyles.label,
                ),
                SizedBox(height: 1.h),

                // Phone Input Field (Matches Image)
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (p, c) => p.phoneError != c.phoneError,
                  builder: (context, state) {
                    final hasError = state.phoneError != null;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            // color: inputBgColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: hasError ? AppColors.error : borderColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                child: Row(
                                  children: [
                                    const Text('🇮🇳', style: TextStyle(fontSize: 18)),
                                    const SizedBox(width: 6),
                                    Text(
                                      '+91',
                                      style: AppTextStyles.bodyLarge.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Container(
                                      height: 24,
                                      width: 1,
                                      color: borderColor,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  onChanged: (val) => context.read<LoginBloc>().add(LoginPhoneChanged(val)),
                                  style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: '98765 43210',
                                    hintStyle: AppTextStyles.bodyLarge.copyWith(color: Colors.white38),
                                    fillColor: Colors.transparent,
                                    filled: false,
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (hasError) ...[
                          const SizedBox(height: 6),
                          Text(
                            state.phoneError!,
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

                SizedBox(height: 4.h),

                // Request OTP Button (Gold Gradient Button matching Image)
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: state.isSubmitting
                          ? null
                          : () {
                              context.read<LoginBloc>().add(const LoginSubmitted());
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
                                  'Request OTP',
                                  style: AppTextStyles.button,
                                ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 3.h),
                const Divider(color: borderColor, height: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
