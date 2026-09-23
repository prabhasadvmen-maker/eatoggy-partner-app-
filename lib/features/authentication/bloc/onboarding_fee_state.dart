import 'package:equatable/equatable.dart';

class OnboardingFeeState extends Equatable {
  final double feeAmount;
  final String gstNotice;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const OnboardingFeeState({
    this.feeAmount = 499.0,
    this.gstNotice = '₹0 extra',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  OnboardingFeeState copyWith({
    double? feeAmount,
    String? gstNotice,
    bool? isSubmitting,
    bool? isSuccess,
    Object? errorMessage = _undefined,
  }) {
    return OnboardingFeeState(
      feeAmount: feeAmount ?? this.feeAmount,
      gstNotice: gstNotice ?? this.gstNotice,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage == _undefined ? this.errorMessage : errorMessage as String?,
    );
  }

  @override
  List<Object?> get props => [
        feeAmount,
        gstNotice,
        isSubmitting,
        isSuccess,
        errorMessage,
      ];
}

const _undefined = Object();
