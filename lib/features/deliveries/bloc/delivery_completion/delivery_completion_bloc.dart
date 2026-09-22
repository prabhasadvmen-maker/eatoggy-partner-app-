import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/delivery_completion_model.dart';
import 'delivery_completion_event.dart';
import 'delivery_completion_state.dart';

class DeliveryCompletionBloc
    extends Bloc<DeliveryCompletionEvent, DeliveryCompletionState> {
  DeliveryCompletionBloc({String orderId = '#EG-7840'})
      : super(DeliveryCompletionState.initial(orderId)) {
    on<LoadDeliveryCompletionEvent>(_onLoadDeliveryCompletion);
    on<NextDeliveryTappedEvent>(_onNextDeliveryTapped);
    on<BackToDashboardTappedEvent>(_onBackToDashboardTapped);
  }

  void _onLoadDeliveryCompletion(
    LoadDeliveryCompletionEvent event,
    Emitter<DeliveryCompletionState> emit,
  ) {
    emit(state.copyWith(
      status: DeliveryCompletionStatus.loaded,
      data: DeliveryCompletionModel.getDummyData(event.orderId),
    ));
  }

  void _onNextDeliveryTapped(
    NextDeliveryTappedEvent event,
    Emitter<DeliveryCompletionState> emit,
  ) {
    emit(state.copyWith(status: DeliveryCompletionStatus.nextDelivery));
  }

  void _onBackToDashboardTapped(
    BackToDashboardTappedEvent event,
    Emitter<DeliveryCompletionState> emit,
  ) {
    emit(state.copyWith(status: DeliveryCompletionStatus.backToDashboard));
  }
}
