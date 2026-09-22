import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/customer_call_model.dart';
import 'customer_call_event.dart';
import 'customer_call_state.dart';

class CustomerCallBloc extends Bloc<CustomerCallEvent, CustomerCallState> {
  CustomerCallBloc({String orderId = '#EG-7840'})
      : super(CustomerCallState.initial(orderId)) {
    on<LoadCustomerCallEvent>(_onLoadCustomerCall);
    on<TriggerVoiceCallEvent>(_onTriggerVoiceCall);
    on<SendQuickMessageEvent>(_onSendQuickMessage);
  }

  void _onLoadCustomerCall(
    LoadCustomerCallEvent event,
    Emitter<CustomerCallState> emit,
  ) {
    emit(state.copyWith(
      status: CustomerCallStatus.loaded,
      data: CustomerCallModel.getDummyData(event.orderId),
      feedbackMessage: null,
    ));
  }

  Future<void> _onTriggerVoiceCall(
    TriggerVoiceCallEvent event,
    Emitter<CustomerCallState> emit,
  ) async {
    final rawNumber = state.data.dialPhone;
    final cleanNumber = rawNumber.replaceAll(RegExp(r'\s+'), '');
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: cleanNumber,
    );

    try {
      final launched = await launchUrl(launchUri);
      if (!launched) {
        emit(state.copyWith(
          feedbackMessage: 'Could not launch dialer for $cleanNumber',
        ));
      } else {
        emit(state.copyWith(
          feedbackMessage: 'Connecting call to secured proxy line...',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        feedbackMessage: 'Error launching call dialer: $e',
      ));
    }
  }

  void _onSendQuickMessage(
    SendQuickMessageEvent event,
    Emitter<CustomerCallState> emit,
  ) {
    emit(state.copyWith(
      feedbackMessage: 'Message dispatched to ${state.data.customerName}',
    ));
  }
}
