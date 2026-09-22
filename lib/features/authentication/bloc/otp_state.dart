import 'package:equatable/equatable.dart';

class OtpState extends Equatable {
  final String phone;
  final List<String> digits;
  final String? otpError;
  final int timerSeconds;
  final bool canResend;
  final bool isSubmitting;
  final bool isSuccess;

  const OtpState({
    this.phone = '+91 98765 43210',
    this.digits = const ['', '', '', ''],
    this.otpError,
    this.timerSeconds = 28,
    this.canResend = false,
    this.isSubmitting = false,
    this.isSuccess = false,
  });

  String get otpCode => digits.join();

  OtpState copyWith({
    String? phone,
    List<String>? digits,
    Object? otpError = _undefined,
    int? timerSeconds,
    bool? canResend,
    bool? isSubmitting,
    bool? isSuccess,
  }) {
    return OtpState(
      phone: phone ?? this.phone,
      digits: digits ?? this.digits,
      otpError: otpError == _undefined ? this.otpError : otpError as String?,
      timerSeconds: timerSeconds ?? this.timerSeconds,
      canResend: canResend ?? this.canResend,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
        phone,
        digits,
        otpError,
        timerSeconds,
        canResend,
        isSubmitting,
        isSuccess,
      ];
}

const _undefined = Object();
