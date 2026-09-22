import 'package:equatable/equatable.dart';

abstract class OnboardingFeeEvent extends Equatable {
  const OnboardingFeeEvent();

  @override
  List<Object?> get props => [];
}

class PaymentSubmitted extends OnboardingFeeEvent {
  final double amount;
  const PaymentSubmitted({this.amount = 499.0});

  @override
  List<Object?> get props => [amount];
}
