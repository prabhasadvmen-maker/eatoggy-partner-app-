import 'package:equatable/equatable.dart';
import '../data/models/support_faq_model.dart';

enum SupportStatus { initial, loading, loaded, error }

class SupportState extends Equatable {
  final SupportStatus status;
  final List<SupportFaqItemModel> faqs;
  final String? expandedFaqId;
  final String? message;

  const SupportState({
    this.status = SupportStatus.initial,
    this.faqs = SupportFaqItemModel.sampleFaqs,
    this.expandedFaqId = 'delivery_issues', // Expanded by default matching screenshot
    this.message,
  });

  SupportState copyWith({
    SupportStatus? status,
    List<SupportFaqItemModel>? faqs,
    String? Function()? expandedFaqId,
    String? message,
  }) {
    return SupportState(
      status: status ?? this.status,
      faqs: faqs ?? this.faqs,
      expandedFaqId:
          expandedFaqId != null ? expandedFaqId() : this.expandedFaqId,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, faqs, expandedFaqId, message];
}
