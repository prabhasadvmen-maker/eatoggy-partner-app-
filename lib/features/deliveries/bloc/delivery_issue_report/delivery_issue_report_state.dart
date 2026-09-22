import 'package:equatable/equatable.dart';
import '../../data/models/delivery_issue_report_model.dart';

enum IssueReportStatus { initial, editing, submitting, success, error }

class DeliveryIssueReportState extends Equatable {
  final IssueReportStatus status;
  final DeliveryIssueReportModel report;
  final String? feedbackMessage;

  const DeliveryIssueReportState({
    required this.status,
    required this.report,
    this.feedbackMessage,
  });

  factory DeliveryIssueReportState.initial(String orderId) {
    return DeliveryIssueReportState(
      status: IssueReportStatus.initial,
      report: DeliveryIssueReportModel.getDummyData(orderId),
    );
  }

  DeliveryIssueReportState copyWith({
    IssueReportStatus? status,
    DeliveryIssueReportModel? report,
    String? feedbackMessage,
  }) {
    return DeliveryIssueReportState(
      status: status ?? this.status,
      report: report ?? this.report,
      feedbackMessage: feedbackMessage,
    );
  }

  @override
  List<Object?> get props => [status, report, feedbackMessage];
}
