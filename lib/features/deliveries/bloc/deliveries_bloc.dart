import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/delivery_category_model.dart';
import 'deliveries_event.dart';
import 'deliveries_state.dart';

class DeliveriesBloc extends Bloc<DeliveriesEvent, DeliveriesState> {
  DeliveriesBloc() : super(const DeliveriesState()) {
    on<LoadDeliveriesData>(_onLoadDeliveriesData);
    on<CategoryTappedEvent>(_onCategoryTapped);
    on<ClearCategorySelectionEvent>(_onClearCategorySelection);
  }

  void _onLoadDeliveriesData(
    LoadDeliveriesData event,
    Emitter<DeliveriesState> emit,
  ) {
    emit(state.copyWith(
      status: DeliveriesStatus.loaded,
      categories: DeliveryCategoryModel.sampleCategories,
    ));
  }

  void _onCategoryTapped(
    CategoryTappedEvent event,
    Emitter<DeliveriesState> emit,
  ) {
    emit(state.copyWith(selectedCategoryId: event.categoryId));
  }

  void _onClearCategorySelection(
    ClearCategorySelectionEvent event,
    Emitter<DeliveriesState> emit,
  ) {
    emit(state.copyWith(clearSelectedCategory: true));
  }
}
