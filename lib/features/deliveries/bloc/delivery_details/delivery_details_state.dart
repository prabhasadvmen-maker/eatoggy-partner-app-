import 'package:equatable/equatable.dart';
import '../../data/models/delivery_details_model.dart';

enum DeliveryDetailsStatus { initial, loading, loaded, error }

class DeliveryDetailsState extends Equatable {
  final DeliveryDetailsStatus status;
  final DeliveryDetailsModel details;
  final String? message;

  const DeliveryDetailsState({
    this.status = DeliveryDetailsStatus.initial,
    this.details = DeliveryDetailsModel.sampleOrder,
    this.message,
  });

  DeliveryDetailsState copyWith({
    DeliveryDetailsStatus? status,
    DeliveryDetailsModel? details,
    String? message,
  }) {
    return DeliveryDetailsState(
      status: status ?? this.status,
      details: details ?? this.details,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, details, message];
}
