import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'active_tour_event.dart';
import 'active_tour_state.dart';
import '../../data/models/active_tour_model.dart';

class ActiveTourBloc extends Bloc<ActiveTourEvent, ActiveTourState> {
  ActiveTourBloc() : super(const ActiveTourState()) {
    on<LoadActiveTourEvent>(_onLoadActiveTour);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<InitiateCustomerCallEvent>(_onInitiateCustomerCall);
    on<DismissTourEvent>(_onDismissTour);
  }

  void _onLoadActiveTour(
      LoadActiveTourEvent event, Emitter<ActiveTourState> emit) {
    emit(state.copyWith(
      status: ActiveTourStatus.inProgress,
      tourData:
          ActiveTourModel.defaultTour.copyWith(orderId: event.orderId),
    ));
  }

  void _onVerifyOtp(VerifyOtpEvent event, Emitter<ActiveTourState> emit) {
    if (event.enteredOtp.trim() == state.tourData.correctOtp) {
      emit(state.copyWith(
        status: ActiveTourStatus.otpVerified,
        tourData: state.tourData.copyWith(isDelivered: true),
        otpError: null,
        message: 'Delivery Verified! Order #EG-7840 completed.',
      ));
    } else {
      emit(state.copyWith(
        status: ActiveTourStatus.error,
        otpError: 'Invalid OTP. Please check with customer (hint: 4821).',
      ));
    }
  }

  Future<void> _onInitiateCustomerCall(
      InitiateCustomerCallEvent event, Emitter<ActiveTourState> emit) async {
    final rawNumber = state.tourData.phoneNumber;
    final cleanNumber = rawNumber.replaceAll(RegExp(r'\s+'), '');
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: cleanNumber,
    );

    try {
      final launched = await launchUrl(launchUri);
      if (!launched) {
        emit(state.copyWith(
          message: 'Could not launch dialer for $cleanNumber',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        message: 'Error opening phone dialer: $e',
      ));
    }
  }

  void _onDismissTour(DismissTourEvent event, Emitter<ActiveTourState> emit) {
    emit(state.copyWith(message: 'Tour dismissed.'));
  }
}
