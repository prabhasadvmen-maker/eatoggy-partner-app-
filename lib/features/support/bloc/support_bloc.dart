import 'package:flutter_bloc/flutter_bloc.dart';
import 'support_event.dart';
import 'support_state.dart';
import '../data/models/support_faq_model.dart';

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  SupportBloc() : super(const SupportState()) {
    on<LoadSupportFaqsEvent>(_onLoadSupportFaqs);
    on<ToggleFaqExpansionEvent>(_onToggleFaqExpansion);
    on<CallSupportEvent>(_onCallSupport);
    on<ChatSupportEvent>(_onChatSupport);
  }

  void _onLoadSupportFaqs(
      LoadSupportFaqsEvent event, Emitter<SupportState> emit) {
    emit(state.copyWith(
      status: SupportStatus.loaded,
      faqs: SupportFaqItemModel.sampleFaqs,
    ));
  }

  void _onToggleFaqExpansion(
      ToggleFaqExpansionEvent event, Emitter<SupportState> emit) {
    if (state.expandedFaqId == event.faqId) {
      // Collapse if already expanded
      emit(state.copyWith(expandedFaqId: () => null));
    } else {
      // Expand tapped FAQ
      emit(state.copyWith(expandedFaqId: () => event.faqId));
    }
  }

  void _onCallSupport(CallSupportEvent event, Emitter<SupportState> emit) {
    emit(state.copyWith(message: 'Connecting to Partner Priority Support Helpline...'));
  }

  void _onChatSupport(ChatSupportEvent event, Emitter<SupportState> emit) {
    emit(state.copyWith(message: 'Opening Live Kitchen Support Chat...'));
  }
}
