import 'package:equatable/equatable.dart';
import '../../data/models/delivery_completion_model.dart';

enum DeliveryCompletionStatus { initial, loading, loaded, nextDelivery, backToDashboard }

class DeliveryCompletionState extends Equatable {
  final DeliveryCompletionStatus status;
  final DeliveryCompletionModel data;

  const DeliveryCompletionState({
    required this.status,
    required this.data,
  });

  factory DeliveryCompletionState.initial(String orderId) {
    return DeliveryCompletionState(
      status: DeliveryCompletionStatus.initial,
      data: DeliveryCompletionModel.getDummyData(orderId),
    );
  }

  DeliveryCompletionState copyWith({
    DeliveryCompletionStatus? status,
    DeliveryCompletionModel? data,
  }) {
    return DeliveryCompletionState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [status, data];
}
