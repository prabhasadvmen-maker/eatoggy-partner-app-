import 'package:equatable/equatable.dart';

abstract class VerificationProtocolEvent extends Equatable {
  const VerificationProtocolEvent();

  @override
  List<Object?> get props => [];
}

class LoadVerificationProtocolEvent extends VerificationProtocolEvent {
  final String orderId;

  const LoadVerificationProtocolEvent(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class OtpChangedEvent extends VerificationProtocolEvent {
  final String otp;

  const OtpChangedEvent(this.otp);

  @override
  List<Object?> get props => [otp];
}

class SubmitVerificationEvent extends VerificationProtocolEvent {
  const SubmitVerificationEvent();
}

class ReportDeliveryIssueEvent extends VerificationProtocolEvent {
  final String issueReason;

  const ReportDeliveryIssueEvent(this.issueReason);

  @override
  List<Object?> get props => [issueReason];
}

class ResetVerificationEvent extends VerificationProtocolEvent {
  const ResetVerificationEvent();
}
