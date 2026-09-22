import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'delivery_details_event.dart';
import 'delivery_details_state.dart';
import '../../data/models/delivery_details_model.dart';

class DeliveryDetailsBloc
    extends Bloc<DeliveryDetailsEvent, DeliveryDetailsState> {
  DeliveryDetailsBloc() : super(const DeliveryDetailsState()) {
    on<LoadDeliveryDetailsEvent>(_onLoadDeliveryDetails);
    on<ConfirmPickupEvent>(_onConfirmPickup);
    on<CallCustomerEvent>(_onCallCustomer);
    on<CopyAddressEvent>(_onCopyAddress);
  }

  void _onLoadDeliveryDetails(
      LoadDeliveryDetailsEvent event, Emitter<DeliveryDetailsState> emit) {
    emit(state.copyWith(
      status: DeliveryDetailsStatus.loaded,
      details: DeliveryDetailsModel.sampleOrder.copyWith(orderId: event.orderId),
    ));
  }

  void _onConfirmPickup(
      ConfirmPickupEvent event, Emitter<DeliveryDetailsState> emit) {
    emit(state.copyWith(
      details: state.details.copyWith(isPickupConfirmed: true),
      message: 'Order pickup confirmed! Navigation updated.',
    ));
  }

  Future<void> _onCallCustomer(
      CallCustomerEvent event, Emitter<DeliveryDetailsState> emit) async {
    final rawNumber = state.details.phoneNumber;
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

  void _onCopyAddress(
      CopyAddressEvent event, Emitter<DeliveryDetailsState> emit) {
    Clipboard.setData(ClipboardData(text: state.details.deliveryLocation));
    emit(state.copyWith(message: 'Address copied to clipboard!'));
  }
}
