import 'package:equatable/equatable.dart';
import '../../data/models/tiffin_subscriber_model.dart';

enum SubscribersStateStatus { initial, loading, loaded, error }

class TiffinSubscribersState extends Equatable {
  final SubscribersStateStatus status;
  final List<TiffinSubscriberModel> allSubscribers;
  final List<TiffinSubscriberModel> filteredSubscribers;
  final String selectedFilter;
  final int totalCount;

  const TiffinSubscribersState({
    this.status = SubscribersStateStatus.initial,
    this.allSubscribers = const [],
    this.filteredSubscribers = const [],
    this.selectedFilter = 'Active',
    this.totalCount = 24,
  });

  TiffinSubscribersState copyWith({
    SubscribersStateStatus? status,
    List<TiffinSubscriberModel>? allSubscribers,
    List<TiffinSubscriberModel>? filteredSubscribers,
    String? selectedFilter,
    int? totalCount,
  }) {
    return TiffinSubscribersState(
      status: status ?? this.status,
      allSubscribers: allSubscribers ?? this.allSubscribers,
      filteredSubscribers: filteredSubscribers ?? this.filteredSubscribers,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  @override
  List<Object?> get props => [
        status,
        allSubscribers,
        filteredSubscribers,
        selectedFilter,
        totalCount,
      ];
}
