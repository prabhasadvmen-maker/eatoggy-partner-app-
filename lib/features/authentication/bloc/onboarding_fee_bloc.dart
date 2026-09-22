import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_fee_event.dart';
import 'onboarding_fee_state.dart';

export 'onboarding_fee_event.dart';
export 'onboarding_fee_state.dart';

class OnboardingFeeBloc extends Bloc<OnboardingFeeEvent, OnboardingFeeState> {
  OnboardingFeeBloc() : super(const OnboardingFeeState()) {
    on<PaymentSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, errorMessage: null));
      await Future.delayed(const Duration(milliseconds: 1000));
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    });
  }
}
