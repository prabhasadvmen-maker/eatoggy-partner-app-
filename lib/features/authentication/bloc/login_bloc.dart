import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

export 'login_event.dart';
export 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginPhoneChanged>((event, emit) {
      final phone = event.phone.trim();
      String? error;
      if (phone.isNotEmpty && !RegExp(r'^[0-9]{10}$').hasMatch(phone.replaceAll(' ', ''))) {
        error = 'Enter a valid 10-digit mobile number';
      }
      emit(state.copyWith(phone: event.phone, phoneError: error));
    });

    on<LoginSubmitted>((event, emit) async {
      final phoneDigits = state.phone.replaceAll(' ', '').trim();
      if (phoneDigits.isEmpty) {
        emit(state.copyWith(phoneError: 'Mobile number is required'));
        return;
      }
      if (phoneDigits.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(phoneDigits)) {
        emit(state.copyWith(phoneError: 'Enter a valid 10-digit mobile number'));
        return;
      }

      emit(state.copyWith(phoneError: null, isSubmitting: true));
      await Future.delayed(const Duration(milliseconds: 800));
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    });
  }
}

