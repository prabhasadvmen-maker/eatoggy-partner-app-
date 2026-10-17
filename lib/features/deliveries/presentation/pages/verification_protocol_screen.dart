import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../bloc/verification_protocol/verification_protocol_bloc.dart';
import '../../bloc/verification_protocol/verification_protocol_event.dart';
import '../../bloc/verification_protocol/verification_protocol_state.dart';
import '../widgets/otp_digit_box.dart';
import 'report_delivery_issue_screen.dart';
import 'cod_payment_screen.dart';

class VerificationProtocolScreen extends StatelessWidget {
  final String orderId;

  const VerificationProtocolScreen({
    super.key,
    this.orderId = '#EG-7840',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerificationProtocolBloc(orderId: orderId)
        ..add(LoadVerificationProtocolEvent(orderId)),
      child: const VerificationProtocolView(),
    );
  }
}

class VerificationProtocolView extends StatefulWidget {
  const VerificationProtocolView({super.key});

  @override
  State<VerificationProtocolView> createState() =>
      _VerificationProtocolViewState();
}

class _VerificationProtocolViewState extends State<VerificationProtocolView> {
  late final TextEditingController _otpController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    _focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context
            .read<VerificationProtocolBloc>()
            .add(OtpChangedEvent(_otpController.text));
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onDigitBoxTapped(int index) {
    if (!_focusNode.hasFocus) {
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerificationProtocolBloc, VerificationProtocolState>(
      listener: (context, state) {
        if (state.status == VerificationStatus.success) {
          // If COD payment, navigate to CodPaymentScreen, else DeliveryCompletionScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => CodPaymentScreen(
                orderId: state.protocol.orderId,
                totalAmount: 847.00,
              ),
            ),
          );
        } else if (state.issueReported != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.surface,
              content: Row(
                children: [
                  const Icon(Icons.info_outline, color: AppColors.primary, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Issue report received: "${state.issueReported}". Fleet support notified.',
                      style: GoogleFonts.inter(color: AppColors.textPrimary, fontSize: 13),
                    ),
                  ),
                ],
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.borderMd,
                side: const BorderSide(color: AppColors.border),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final entered = state.enteredOtp;

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(
            child: Stack(
              children: [
                // Hidden textfield capturing soft keyboard
                Opacity(
                  opacity: 0.0,
                  child: SizedBox(
                    width: 1,
                    height: 1,
                    child: TextField(
                      controller: _otpController,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      onChanged: (val) {
                        context
                            .read<VerificationProtocolBloc>()
                            .add(OtpChangedEvent(val));
                      },
                    ),
                  ),
                ),

                // Main content
                SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // Back Button
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.border,
                              width: 1.0,
                            ),
                            boxShadow: AppShadows.card,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.textPrimary,
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Title: "Verification Protocol"
                      Text(
                        state.protocol.title,
                        style: GoogleFonts.fraunces(
                          color: AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Subtitle
                      Text(
                        state.protocol.subtitle,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 14.5,
                        ),
                      ),
                      const SizedBox(height: 36),

                      // 4 Large OTP Digit Boxes Row matching d10-delivery-otp.svg
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(4, (index) {
                          final digit = index < entered.length ? entered[index] : '';
                          final isFilled = digit.isNotEmpty;
                          final isFocused = _focusNode.hasFocus &&
                              (index == entered.length ||
                                  (index == 3 && entered.length == 4));

                          return OtpDigitBox(
                            digit: digit,
                            isFocused: isFocused,
                            isFilled: isFilled,
                            onTap: () => _onDigitBoxTapped(index),
                          );
                        }),
                      ),

                      // Error message if any
                      if (state.errorMessage != null) ...[
                        const SizedBox(height: 14),
                        Center(
                          child: Text(
                            state.errorMessage!,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: AppColors.error,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(height: 24),

                      // Helper text
                      Center(
                        child: Text(
                          state.protocol.infoText,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),

                      // CTA Button: "Verify & Complete Delivery" (Crimson Button)
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: state.status == VerificationStatus.verifying
                              ? null
                              : () {
                                  context
                                      .read<VerificationProtocolBloc>()
                                      .add(const SubmitVerificationEvent());
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: AppRadius.borderLg,
                            ),
                          ),
                          child: state.status == VerificationStatus.verifying
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Verify & Complete Delivery',
                                  style: GoogleFonts.inter(
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.1,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Red link: "Report Issue"
                      Center(
                        child: TextButton(
                          onPressed: () async {
                            final reason = await Navigator.push<String>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ReportDeliveryIssueScreen(
                                  orderId: state.protocol.orderId,
                                ),
                              ),
                            );
                            if (reason != null && context.mounted) {
                              context
                                  .read<VerificationProtocolBloc>()
                                  .add(ReportDeliveryIssueEvent(reason));
                            }
                          },
                          child: Text(
                            'Report Issue',
                            style: GoogleFonts.inter(
                              color: AppColors.error,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
