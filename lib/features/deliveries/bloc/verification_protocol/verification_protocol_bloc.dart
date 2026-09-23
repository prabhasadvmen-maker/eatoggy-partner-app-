import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/verification_protocol_model.dart';
import 'verification_protocol_event.dart';
import 'verification_protocol_state.dart';

class VerificationProtocolBloc
    extends Bloc<VerificationProtocolEvent, VerificationProtocolState> {
  VerificationProtocolBloc({String orderId = '#EG-7840'})
      : super(VerificationProtocolState.initial(orderId)) {
    on<LoadVerificationProtocolEvent>(_onLoadVerificationProtocol);
    on<OtpChangedEvent>(_onOtpChanged);
    on<SubmitVerificationEvent>(_onSubmitVerification);
    on<ReportDeliveryIssueEvent>(_onReportDeliveryIssue);
    on<ResetVerificationEvent>(_onResetVerification);
  }

  void _onLoadVerificationProtocol(
    LoadVerificationProtocolEvent event,
    Emitter<VerificationProtocolState> emit,
  ) {
    emit(state.copyWith(
      status: VerificationStatus.inputting,
      protocol: VerificationProtocolModel.getDummyData(event.orderId),
      enteredOtp: '',
      errorMessage: null,
    ));
  }

  void _onOtpChanged(
    OtpChangedEvent event,
    Emitter<VerificationProtocolState> emit,
  ) {
    emit(state.copyWith(
      status: VerificationStatus.inputting,
      enteredOtp: event.otp,
      errorMessage: null,
    ));
  }

  Future<void> _onSubmitVerification(
    SubmitVerificationEvent event,
    Emitter<VerificationProtocolState> emit,
  ) async {
    final cleanOtp = state.enteredOtp.trim();
    if (cleanOtp.length < 4) {
      emit(state.copyWith(
        status: VerificationStatus.failure,
        errorMessage: 'Please enter a complete 4-digit code',
      ));
      return;
    }

    emit(state.copyWith(status: VerificationStatus.verifying, errorMessage: null));

    // Simulate luxury verification network delay
    await Future.delayed(const Duration(milliseconds: 600));

    // Valid OTPs: 2048 (from screenshot mockup) or model validOtp or 4821
    if (cleanOtp == state.protocol.validOtp || cleanOtp == '2048' || cleanOtp == '4821') {
      emit(state.copyWith(
        status: VerificationStatus.success,
        protocol: state.protocol.copyWith(isVerified: true),
        errorMessage: null,
      ));
    } else {
      emit(state.copyWith(
        status: VerificationStatus.failure,
        errorMessage: 'Invalid OTP code. Please check with customer.',
      ));
    }
  }

  void _onReportDeliveryIssue(
    ReportDeliveryIssueEvent event,
    Emitter<VerificationProtocolState> emit,
  ) {
    emit(state.copyWith(
      issueReported: event.issueReason,
      errorMessage: null,
    ));
  }

  void _onResetVerification(
    ResetVerificationEvent event,
    Emitter<VerificationProtocolState> emit,
  ) {
    emit(state.copyWith(
      status: VerificationStatus.inputting,
      enteredOtp: '',
      errorMessage: null,
    ));
  }
}
