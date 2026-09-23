import 'package:equatable/equatable.dart';
import '../../data/models/customer_call_model.dart';

enum CustomerCallStatus { initial, loading, loaded, calling, error }

class CustomerCallState extends Equatable {
  final CustomerCallStatus status;
  final CustomerCallModel data;
  final String? feedbackMessage;

  const CustomerCallState({
    required this.status,
    required this.data,
    this.feedbackMessage,
  });

  factory CustomerCallState.initial(String orderId) {
    return CustomerCallState(
      status: CustomerCallStatus.initial,
      data: CustomerCallModel.getDummyData(orderId),
    );
  }

  CustomerCallState copyWith({
    CustomerCallStatus? status,
    CustomerCallModel? data,
    String? feedbackMessage,
  }) {
    return CustomerCallState(
      status: status ?? this.status,
      data: data ?? this.data,
      feedbackMessage: feedbackMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, feedbackMessage];
}
