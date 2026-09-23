import 'package:equatable/equatable.dart';

abstract class DeliveryIssueReportEvent extends Equatable {
  const DeliveryIssueReportEvent();

  @override
  List<Object?> get props => [];
}

class LoadDeliveryIssueReportEvent extends DeliveryIssueReportEvent {
  final String orderId;

  const LoadDeliveryIssueReportEvent(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class SelectIssueReasonEvent extends DeliveryIssueReportEvent {
  final String reason;

  const SelectIssueReasonEvent(this.reason);

  @override
  List<Object?> get props => [reason];
}

class UpdateAdditionalNotesEvent extends DeliveryIssueReportEvent {
  final String notes;

  const UpdateAdditionalNotesEvent(this.notes);

  @override
  List<Object?> get props => [notes];
}

class AttachPhotoEvidenceEvent extends DeliveryIssueReportEvent {
  final String? imagePath;

  const AttachPhotoEvidenceEvent(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class SubmitDeliveryIssueReportEvent extends DeliveryIssueReportEvent {
  const SubmitDeliveryIssueReportEvent();
}
