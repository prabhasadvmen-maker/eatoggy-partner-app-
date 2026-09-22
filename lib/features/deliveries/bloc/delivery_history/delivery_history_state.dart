import 'package:equatable/equatable.dart';
import '../../data/models/delivery_history_model.dart';

enum HistoryStateStatus { initial, loading, loaded, error }

class DeliveryHistoryState extends Equatable {
  final HistoryStateStatus status;
  final List<DeliveryHistoryModel> allHistory;
  final List<DeliveryHistoryModel> filteredHistory;
  final String selectedFilter;

  const DeliveryHistoryState({
    this.status = HistoryStateStatus.initial,
    this.allHistory = const [],
    this.filteredHistory = const [],
    this.selectedFilter = 'Today',
  });

  DeliveryHistoryState copyWith({
    HistoryStateStatus? status,
    List<DeliveryHistoryModel>? allHistory,
    List<DeliveryHistoryModel>? filteredHistory,
    String? selectedFilter,
  }) {
    return DeliveryHistoryState(
      status: status ?? this.status,
      allHistory: allHistory ?? this.allHistory,
      filteredHistory: filteredHistory ?? this.filteredHistory,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }

  @override
  List<Object?> get props => [
        status,
        allHistory,
        filteredHistory,
        selectedFilter,
      ];
}
