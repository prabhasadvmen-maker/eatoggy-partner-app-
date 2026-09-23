import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class OtpVerificationSheet extends StatefulWidget {
  final String correctOtp;
  final ValueChanged<String> onVerified;

  const OtpVerificationSheet({
    super.key,
    required this.correctOtp,
    required this.onVerified,
  });

  @override
  State<OtpVerificationSheet> createState() => _OtpVerificationSheetState();
}

class _OtpVerificationSheetState extends State<OtpVerificationSheet> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  String? _errorMessage;
  bool _isSuccess = false;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _verifyOtp() {
    final entered = _controllers.map((c) => c.text).join();
    if (entered.length < 4) {
      setState(() {
        _errorMessage = 'Please enter all 4 digits.';
      });
      return;
    }

    if (entered == widget.correctOtp) {
      setState(() {
        _errorMessage = null;
        _isSuccess = true;
      });
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          Navigator.pop(context);
          widget.onVerified(entered);
        }
      });
    } else {
      setState(() {
        _errorMessage = 'Invalid OTP. Please check with customer (hint: ${widget.correctOtp}).';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const goldColor = AppColors.cardGoldAccent;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(22, 16, 22, 28),
        decoration: const BoxDecoration(
          color: Color(0xFF161618),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          border: Border(
            top: BorderSide(
              color: Color(0xFF262628),
              width: 1.2,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle pill
              Center(
                child: Container(
                  width: 38,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF333338),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Title
              Text(
                'Enter Delivery OTP',
                style: GoogleFonts.fraunces(
                  color: AppColors.creamText,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),

              Text(
                'Ask customer for the 4-digit code provided on their app (hint: ${widget.correctOtp})',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0xFF8E8E93),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 24),

              // 4 Digit Input Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    width: 54,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E22),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _controllers[index].text.isNotEmpty
                            ? goldColor
                            : const Color(0xFF2E2E34),
                        width: 1.4,
                      ),
                    ),
                    child: Center(
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        style: GoogleFonts.fraunces(
                          color: goldColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                        ),
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            if (index < 3) {
                              _focusNodes[index + 1].requestFocus();
                            } else {
                              _focusNodes[index].unfocus();
                              _verifyOtp();
                            }
                          } else if (index > 0) {
                            _focusNodes[index - 1].requestFocus();
                          }
                          setState(() {});
                        },
                      ),
                    ),
                  );
                }),
              ),

              if (_errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFFE54D4D),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Verify & Complete Button
              InkWell(
                onTap: _isSuccess ? null : _verifyOtp,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: _isSuccess ? const Color(0xFF00E676) : goldColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: (_isSuccess
                                ? const Color(0xFF00E676)
                                : goldColor)
                            .withValues(alpha: 0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      _isSuccess
                          ? 'OTP Verified ✓'
                          : 'Verify & Complete Delivery',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF141416),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
