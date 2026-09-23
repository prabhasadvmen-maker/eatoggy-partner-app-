import 'package:equatable/equatable.dart';

abstract class SupportEvent extends Equatable {
  const SupportEvent();

  @override
  List<Object?> get props => [];
}

class LoadSupportFaqsEvent extends SupportEvent {
  const LoadSupportFaqsEvent();
}

class ToggleFaqExpansionEvent extends SupportEvent {
  final String faqId;

  const ToggleFaqExpansionEvent(this.faqId);

  @override
  List<Object?> get props => [faqId];
}

class CallSupportEvent extends SupportEvent {
  const CallSupportEvent();
}

class ChatSupportEvent extends SupportEvent {
  const ChatSupportEvent();
}
