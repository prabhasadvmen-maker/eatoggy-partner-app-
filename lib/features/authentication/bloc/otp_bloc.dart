import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_event.dart';
import 'otp_state.dart';

export 'otp_event.dart';
export 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  Timer? _timer;

  OtpBloc({String phone = '+91 98765 43210'}) : super(OtpState(phone: phone)) {
    _startTimer();

    on<OtpDigitChanged>((event, emit) {
      final newDigits = List<String>.from(state.digits);
      if (event.index >= 0 && event.index < 4) {
        newDigits[event.index] = event.digit;
      }
      emit(state.copyWith(digits: newDigits, otpError: null));
    });

    on<OtpTick>((event, emit) {
      if (state.timerSeconds > 1) {
        emit(state.copyWith(timerSeconds: state.timerSeconds - 1));
      } else {
        _timer?.cancel();
        emit(state.copyWith(timerSeconds: 0, canResend: true));
      }
    });

    on<OtpResendRequested>((event, emit) {
      _timer?.cancel();
      emit(state.copyWith(timerSeconds: 30, canResend: false, otpError: null));
      _startTimer();
    });

    on<OtpSubmitted>((event, emit) async {
      final code = state.digits.join().trim();
      final hasEmpty = state.digits.any((d) => d.trim().isEmpty);
      if (code.length < 4 || hasEmpty) {
        emit(state.copyWith(otpError: 'Please enter complete 4-digit OTP'));
        return;
      }

      emit(state.copyWith(otpError: null, isSubmitting: true));
      await Future.delayed(const Duration(milliseconds: 800));
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(const OtpTick());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
