import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../bloc/register_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final VoidCallback onRegisterSuccess;
  final VoidCallback onLoginTap;

  const RegisterScreen({
    super.key,
    required this.onRegisterSuccess,
    required this.onLoginTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: RegisterView(
        onRegisterSuccess: onRegisterSuccess,
        onLoginTap: onLoginTap,
      ),
    );
  }
}

class RegisterView extends StatefulWidget {
  final VoidCallback onRegisterSuccess;
  final VoidCallback onLoginTap;

  const RegisterView({
    super.key,
    required this.onRegisterSuccess,
    required this.onLoginTap,
  });

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  final List<String> _cities = [
    'Delhi NCR (Connaught Place)',
    'Gurugram (Cyber Hub)',
    'Noida (Sector 18)',
    'Mumbai (Bandra West)',
    'Bengaluru (Indiranagar)',
  ];

  final List<String> _vehicles = [
    'Bike / Scooter / Car',
    'Scooter / EV',
    'Car / Four Wheeler',
    'Bicycle',
  ];

  @override
  void initState() {
    super.initState();
    final state = context.read<RegisterBloc>().state;
    _nameController = TextEditingController(text: state.name);
    _emailController = TextEditingController(text: state.email);
    _phoneController = TextEditingController(text: state.phone);
    _passwordController = TextEditingController(text: state.password);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = AppColors.darkBackground;
    const goldColor = AppColors.goldFont;
    const borderColor = AppColors.darkBorder;
    const inputBgColor = AppColors.darkSurface;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.isSuccess) {
              widget.onRegisterSuccess();
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1.h),

                // Header Badge & App Name
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: goldColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: goldColor,
                              blurRadius: 6,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'EATOGGY LOGISTICS',
                        style: AppTextStyles.label,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 2.5.h),

                // Title & Subtitle
                Text(
                  'Join EATOGGY Partners',
                  style: AppTextStyles.headingLarge,
                ),
                SizedBox(height: 0.5.h),
                Text(
                  'Register as a Delivery Partner',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white70,
                  ),
                ),

                SizedBox(height: 2.h),

                // FULL NAME
                _buildLabel('FULL NAME'),
                SizedBox(height: 1.h),
                BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (p, c) => p.nameError != c.nameError,
                  builder: (context, state) {
                    return _buildTextField(
                      controller: _nameController,
                      hintText: 'Enter full name',
                      errorText: state.nameError,
                      onChanged: (val) => context.read<RegisterBloc>().add(RegisterNameChanged(val)),
                      borderColor: borderColor,
                      inputBgColor: inputBgColor,
                    );
                  },
                ),

                SizedBox(height: 1.5.h),

                // EMAIL ADDRESS
                _buildLabel('EMAIL ADDRESS'),
                SizedBox(height: 1.h),
                BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (p, c) => p.emailError != c.emailError,
                  builder: (context, state) {
                    return _buildTextField(
                      controller: _emailController,
                      hintText: 'Enter email address',
                      errorText: state.emailError,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) => context.read<RegisterBloc>().add(RegisterEmailChanged(val)),
                      borderColor: borderColor,
                      inputBgColor: inputBgColor,
                    );
                  },
                ),

                SizedBox(height: 1.5.h),

                // MOBILE NUMBER
                _buildLabel('MOBILE NUMBER'),
                SizedBox(height: 1.h),
                BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (p, c) => p.phoneError != c.phoneError,
                  builder: (context, state) {
                    final hasError = state.phoneError != null;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: inputBgColor,
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
                                  onChanged: (val) => context.read<RegisterBloc>().add(RegisterPhoneChanged(val)),
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

                SizedBox(height: 1.5.h),

                // CITY / ZONE
                _buildLabel('CITY / ZONE'),
                SizedBox(height: 1.h),
                BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (p, c) => p.selectedCity != c.selectedCity || p.cityError != c.cityError,
                  builder: (context, state) {
                    return _buildDropdownField(
                      hintText: 'Select operational city',
                      value: state.selectedCity,
                      errorText: state.cityError,
                      items: _cities,
                      onChanged: (val) {
                        if (val != null) {
                          context.read<RegisterBloc>().add(RegisterCityChanged(val));
                        }
                      },
                      borderColor: borderColor,
                      inputBgColor: inputBgColor,
                    );
                  },
                ),

                SizedBox(height: 1.5.h),

                // VEHICLE TYPE
                _buildLabel('VEHICLE TYPE'),
                SizedBox(height: 1.h),
                BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (p, c) => p.selectedVehicle != c.selectedVehicle || p.vehicleError != c.vehicleError,
                  builder: (context, state) {
                    return _buildDropdownField(
                      hintText: 'Bike / Scooter / Car',
                      value: state.selectedVehicle,
                      errorText: state.vehicleError,
                      items: _vehicles,
                      onChanged: (val) {
                        if (val != null) {
                          context.read<RegisterBloc>().add(RegisterVehicleChanged(val));
                        }
                      },
                      borderColor: borderColor,
                      inputBgColor: inputBgColor,
                    );
                  },
                ),

                SizedBox(height: 1.5.h),

                // SET PASSWORD
                _buildLabel('SET PASSWORD'),
                SizedBox(height: 1.h),
                BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (p, c) => p.obscurePassword != c.obscurePassword || p.passwordError != c.passwordError,
                  builder: (context, state) {
                    final hasError = state.passwordError != null;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: inputBgColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: hasError ? AppColors.error : borderColor,
                            ),
                          ),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: state.obscurePassword,
                            onChanged: (val) => context.read<RegisterBloc>().add(RegisterPasswordChanged(val)),
                            style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Create secure password',
                              hintStyle: AppTextStyles.bodyLarge.copyWith(color: Colors.white38),
                              fillColor: Colors.transparent,
                              filled: false,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  color: Colors.white54,
                                ),
                                onPressed: () {
                                  context.read<RegisterBloc>().add(const RegisterTogglePasswordVisibility());
                                },
                              ),
                            ),
                          ),
                        ),
                        if (hasError) ...[
                          const SizedBox(height: 6),
                          Text(
                            state.passwordError!,
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

                // CREATE ACCOUNT BUTTON
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: state.isSubmitting
                          ? null
                          : () {
                              context.read<RegisterBloc>().add(const RegisterSubmitted());
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
                                  'Create Account',
                                  style: AppTextStyles.button,
                                ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 2.h),

                // Already have an account? Login
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
                      ),
                      GestureDetector(
                        onTap: widget.onLoginTap,
                        child: Text(
                          'Login',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: goldColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: AppTextStyles.label,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    String? errorText,
    TextInputType keyboardType = TextInputType.text,
    required ValueChanged<String> onChanged,
    required Color borderColor,
    required Color inputBgColor,
  }) {
    final hasError = errorText != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: inputBgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: hasError ? AppColors.error : borderColor,
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged,
            style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTextStyles.bodyLarge.copyWith(color: Colors.white38),
              fillColor: Colors.transparent,
              filled: false,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 6),
          Text(
            errorText,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.error,
              fontSize: 12.sp,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDropdownField({
    required String hintText,
    required String? value,
    String? errorText,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required Color borderColor,
    required Color inputBgColor,
  }) {
    final hasError = errorText != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: inputBgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: hasError ? AppColors.error : borderColor,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Text(
                hintText,
                style: AppTextStyles.bodyLarge.copyWith(color: Colors.white38),
              ),
              isExpanded: true,
              dropdownColor: inputBgColor,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.goldFont),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 6),
          Text(
            errorText,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.error,
              fontSize: 12.sp,
            ),
          ),
        ],
      ],
    );
  }
}
