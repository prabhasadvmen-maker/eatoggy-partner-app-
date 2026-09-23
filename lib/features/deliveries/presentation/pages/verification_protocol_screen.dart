import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/verification_protocol/verification_protocol_bloc.dart';
import '../../bloc/verification_protocol/verification_protocol_event.dart';
import '../../bloc/verification_protocol/verification_protocol_state.dart';
import '../widgets/otp_digit_box.dart';
import 'report_delivery_issue_screen.dart';
import 'delivery_completion_screen.dart';

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

    // Trigger initial event so BLoC is in sync with initial value
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => DeliveryCompletionScreen(
                orderId: state.protocol.orderId,
              ),
            ),
          );
        } else if (state.issueReported != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color(0xFF2A1C1C),
              content: Row(
                children: [
                  const Icon(Icons.info_outline, color: AppColors.cardGoldAccent, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Issue report received: "${state.issueReported}". Fleet support notified.',
                      style: GoogleFonts.inter(color: AppColors.creamText, fontSize: 13),
                    ),
                  ),
                ],
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
        }
      },
      builder: (context, state) {
        final entered = state.enteredOtp;

        return Scaffold(
          backgroundColor: AppColors.darkBackground,
          body: SafeArea(
            child: Stack(
              children: [
                // Off-screen hidden textfield that captures soft keyboard input
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
                            color: const Color(0xFF1E1E1C),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF2E2E2A),
                              width: 1.0,
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.creamText,
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Title: "Verification Protocol"
                      Text(
                        state.protocol.title,
                        style: GoogleFonts.fraunces(
                          color: AppColors.creamText,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Subtitle: "Enter the secure code shared by the customer"
                      Text(
                        state.protocol.subtitle,
                        style: GoogleFonts.inter(
                          color: AppColors.textSecondaryDark,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 36),

                      // 4 Large OTP Digit Boxes Row (matching screenshot)
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

                      // Helper text: "OTP was sent to customer's registered smartphone app."
                      Center(
                        child: Text(
                          state.protocol.infoText,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: AppColors.textMutedDark,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),

                      // CTA Button: "Verify & Complete Delivery" (Gold Button)
                      InkWell(
                        onTap: state.status == VerificationStatus.verifying
                            ? null
                            : () {
                                context
                                    .read<VerificationProtocolBloc>()
                                    .add(const SubmitVerificationEvent());
                              },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFE8B669),
                                Color(0xFFD69C45),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFD69C45).withValues(alpha: 0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: state.status == VerificationStatus.verifying
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Color(0xFF11110F),
                                    ),
                                  )
                                : Text(
                                    'Verify & Complete Delivery',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF11110F),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.1,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),

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
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.error,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: Text(
                            'Report Issue',
                            style: GoogleFonts.inter(
                              color: AppColors.error,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
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
