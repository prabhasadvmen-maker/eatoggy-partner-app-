import 'package:equatable/equatable.dart';
import '../data/models/delivery_category_model.dart';

enum DeliveriesStatus { initial, loading, loaded, error }

class DeliveriesState extends Equatable {
  final DeliveriesStatus status;
  final List<DeliveryCategoryModel> categories;
  final String? selectedCategoryId;
  final String headerTitle;
  final String headerSubtitle;

  const DeliveriesState({
    this.status = DeliveriesStatus.initial,
    this.categories = const [],
    this.selectedCategoryId,
    this.headerTitle = 'Deliveries',
    this.headerSubtitle = 'Manage all your deliveries',
  });

  DeliveriesState copyWith({
    DeliveriesStatus? status,
    List<DeliveryCategoryModel>? categories,
    String? selectedCategoryId,
    bool clearSelectedCategory = false,
    String? headerTitle,
    String? headerSubtitle,
  }) {
    return DeliveriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      selectedCategoryId: clearSelectedCategory
          ? null
          : (selectedCategoryId ?? this.selectedCategoryId),
      headerTitle: headerTitle ?? this.headerTitle,
      headerSubtitle: headerSubtitle ?? this.headerSubtitle,
    );
  }

  @override
  List<Object?> get props => [
        status,
        categories,
        selectedCategoryId,
        headerTitle,
        headerSubtitle,
      ];
}
