import 'package:equatable/equatable.dart';
import '../../data/models/verification_protocol_model.dart';

enum VerificationStatus { initial, loading, inputting, verifying, success, failure }

class VerificationProtocolState extends Equatable {
  final VerificationStatus status;
  final VerificationProtocolModel protocol;
  final String enteredOtp;
  final String? errorMessage;
  final String? issueReported;

  const VerificationProtocolState({
    required this.status,
    required this.protocol,
    this.enteredOtp = '',
    this.errorMessage,
    this.issueReported,
  });

  factory VerificationProtocolState.initial(String orderId) {
    return VerificationProtocolState(
      status: VerificationStatus.initial,
      protocol: VerificationProtocolModel.getDummyData(orderId),
      enteredOtp: '',
    );
  }

  VerificationProtocolState copyWith({
    VerificationStatus? status,
    VerificationProtocolModel? protocol,
    String? enteredOtp,
    String? errorMessage,
    String? issueReported,
  }) {
    return VerificationProtocolState(
      status: status ?? this.status,
      protocol: protocol ?? this.protocol,
      enteredOtp: enteredOtp ?? this.enteredOtp,
      errorMessage: errorMessage,
      issueReported: issueReported,
    );
  }

  @override
  List<Object?> get props => [
        status,
        protocol,
        enteredOtp,
        errorMessage,
        issueReported,
      ];
}
