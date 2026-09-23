import 'package:equatable/equatable.dart';

abstract class DeliveriesEvent extends Equatable {
  const DeliveriesEvent();

  @override
  List<Object?> get props => [];
}

class LoadDeliveriesData extends DeliveriesEvent {
  const LoadDeliveriesData();
}

class CategoryTappedEvent extends DeliveriesEvent {
  final String categoryId;

  const CategoryTappedEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class ClearCategorySelectionEvent extends DeliveriesEvent {
  const ClearCategorySelectionEvent();
}
