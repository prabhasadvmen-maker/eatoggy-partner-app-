import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/common_widgets.dart';
import '../bloc/bank_details_bloc.dart';

class BankDetailsScreen extends StatelessWidget {
  final VoidCallback onVerifySuccess;

  const BankDetailsScreen({
    super.key,
    required this.onVerifySuccess,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BankDetailsBloc(),
      child: BankDetailsView(
        onVerifySuccess: onVerifySuccess,
      ),
    );
  }
}

class BankDetailsView extends StatefulWidget {
  final VoidCallback onVerifySuccess;

  const BankDetailsView({
    super.key,
    required this.onVerifySuccess,
  });

  @override
  State<BankDetailsView> createState() => _BankDetailsViewState();
}

class _BankDetailsViewState extends State<BankDetailsView> {
  late TextEditingController _nameController;
  late TextEditingController _accountNumberController;
  late TextEditingController _confirmAccountNumberController;
  late TextEditingController _ifscController;

  @override
  void initState() {
    super.initState();
    final state = context.read<BankDetailsBloc>().state;
    _nameController = TextEditingController(text: state.accountHolderName);
    _accountNumberController = TextEditingController(text: state.accountNumber);
    _confirmAccountNumberController = TextEditingController(text: state.confirmAccountNumber);
    _ifscController = TextEditingController(text: state.ifscCode);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _accountNumberController.dispose();
    _confirmAccountNumberController.dispose();
    _ifscController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = AppColors.background;
    const borderColor = AppColors.border;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: BlocListener<BankDetailsBloc, BankDetailsState>(
          listener: (context, state) {
            if (state.isSuccess) {
              widget.onVerifySuccess();
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1.h),

                // STEP 2 OF 3
                const StepIndicator(currentStep: 2, totalSteps: 3),
                SizedBox(height: 1.2.h),

                // Add bank account
                Text(
                  'Add bank account',
                  style: AppTextStyles.displayLarge,
                ),
                SizedBox(height: 1.2.h),

                // Subtitle
                Text(
                  'Add the account where you would like to receive your partner payouts.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    height: 1.4,
                  ),
                ),

                SizedBox(height: 3.5.h),

                // ACCOUNT HOLDER NAME
                _buildLabel('ACCOUNT HOLDER NAME'),
                SizedBox(height: 1.h),
                BlocBuilder<BankDetailsBloc, BankDetailsState>(
                  buildWhen: (p, c) => p.nameError != c.nameError,
                  builder: (context, state) {
                    return _buildInputField(
                      controller: _nameController,
                      hintText: 'Ravi Kumar',
                      icon: Icons.person_outline_rounded,
                      errorText: state.nameError,
                      onChanged: (val) => context.read<BankDetailsBloc>().add(AccountHolderNameChanged(val)),
                      borderColor: borderColor,
                    );
                  },
                ),

                SizedBox(height: 2.h),

                // ACCOUNT NUMBER
                _buildLabel('ACCOUNT NUMBER'),
                SizedBox(height: 1.h),
                BlocBuilder<BankDetailsBloc, BankDetailsState>(
                  buildWhen: (p, c) => p.accountNumberError != c.accountNumberError,
                  builder: (context, state) {
                    return _buildInputField(
                      controller: _accountNumberController,
                      hintText: '•••• •••• 4321',
                      icon: Icons.account_balance_wallet_outlined,
                      errorText: state.accountNumberError,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(18),
                      ],
                      onChanged: (val) => context.read<BankDetailsBloc>().add(AccountNumberChanged(val)),
                      borderColor: borderColor,
                    );
                  },
                ),

                SizedBox(height: 2.h),

                // CONFIRM ACCOUNT NUMBER
                _buildLabel('CONFIRM ACCOUNT NUMBER'),
                SizedBox(height: 1.h),
                BlocBuilder<BankDetailsBloc, BankDetailsState>(
                  buildWhen: (p, c) => p.confirmAccountNumberError != c.confirmAccountNumberError,
                  builder: (context, state) {
                    return _buildInputField(
                      controller: _confirmAccountNumberController,
                      hintText: '•••• •••• 4321',
                      icon: Icons.check_circle_outline_rounded,
                      errorText: state.confirmAccountNumberError,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(18),
                      ],
                      onChanged: (val) => context.read<BankDetailsBloc>().add(ConfirmAccountNumberChanged(val)),
                      borderColor: borderColor,
                    );
                  },
                ),

                SizedBox(height: 2.h),

                // IFSC CODE
                _buildLabel('IFSC CODE'),
                SizedBox(height: 1.h),
                BlocBuilder<BankDetailsBloc, BankDetailsState>(
                  buildWhen: (p, c) => p.ifscError != c.ifscError,
                  builder: (context, state) {
                    return _buildInputField(
                      controller: _ifscController,
                      hintText: 'HDFC0001234',
                      icon: Icons.apartment_rounded,
                      errorText: state.ifscError,
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                      ],
                      onChanged: (val) => context.read<BankDetailsBloc>().add(IfscCodeChanged(val)),
                      borderColor: borderColor,
                    );
                  },
                ),

                SizedBox(height: 3.h),

                // Instant bank verification Card
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
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: AppColors.successLight,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.verified_user_outlined,
                          color: AppColors.success,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 3.5.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Instant bank verification',
                              style: AppTextStyles.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "We'll deposit ₹1 to verify your account details.",
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 3.5.h),

                // Security Note
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
                        'Your banking details are safe and never shared',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 2.5.h),

                // Verify & Continue Button (Solid Crimson Red)
                BlocBuilder<BankDetailsBloc, BankDetailsState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppDimensions.buttonHeight,
                      child: ElevatedButton(
                        onPressed: state.isSubmitting
                            ? null
                            : () {
                                context.read<BankDetailsBloc>().add(const BankDetailsSubmitted());
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
                                'Verify & Continue',
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

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: AppTextStyles.label,
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    String? errorText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
    required ValueChanged<String> onChanged,
    required Color borderColor,
  }) {
    final hasError = errorText != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.borderLg,
            border: Border.all(
              color: hasError ? AppColors.error : borderColor,
              width: 1.2,
            ),
            boxShadow: AppShadows.card,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  icon,
                  color: AppColors.textSecondary,
                  size: 22,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  obscureText: obscureText,
                  textCapitalization: textCapitalization,
                  inputFormatters: inputFormatters,
                  onChanged: onChanged,
                  style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPlaceholder),
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
