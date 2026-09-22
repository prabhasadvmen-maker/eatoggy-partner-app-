import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/delivery_issue_report_model.dart';
import 'delivery_issue_report_event.dart';
import 'delivery_issue_report_state.dart';

class DeliveryIssueReportBloc
    extends Bloc<DeliveryIssueReportEvent, DeliveryIssueReportState> {
  DeliveryIssueReportBloc({String orderId = '#EG-7840'})
      : super(DeliveryIssueReportState.initial(orderId)) {
    on<LoadDeliveryIssueReportEvent>(_onLoadDeliveryIssueReport);
    on<SelectIssueReasonEvent>(_onSelectIssueReason);
    on<UpdateAdditionalNotesEvent>(_onUpdateAdditionalNotes);
    on<AttachPhotoEvidenceEvent>(_onAttachPhotoEvidence);
    on<SubmitDeliveryIssueReportEvent>(_onSubmitDeliveryIssueReport);
  }

  void _onLoadDeliveryIssueReport(
    LoadDeliveryIssueReportEvent event,
    Emitter<DeliveryIssueReportState> emit,
  ) {
    emit(state.copyWith(
      status: IssueReportStatus.editing,
      report: DeliveryIssueReportModel.getDummyData(event.orderId),
      feedbackMessage: null,
    ));
  }

  void _onSelectIssueReason(
    SelectIssueReasonEvent event,
    Emitter<DeliveryIssueReportState> emit,
  ) {
    emit(state.copyWith(
      status: IssueReportStatus.editing,
      report: state.report.copyWith(selectedReason: event.reason),
      feedbackMessage: null,
    ));
  }

  void _onUpdateAdditionalNotes(
    UpdateAdditionalNotesEvent event,
    Emitter<DeliveryIssueReportState> emit,
  ) {
    emit(state.copyWith(
      report: state.report.copyWith(additionalNotes: event.notes),
    ));
  }

  void _onAttachPhotoEvidence(
    AttachPhotoEvidenceEvent event,
    Emitter<DeliveryIssueReportState> emit,
  ) {
    emit(state.copyWith(
      report: state.report.copyWith(
        photoEvidencePath: event.imagePath,
        clearPhotoEvidence: event.imagePath == null,
      ),
      feedbackMessage: event.imagePath != null
          ? 'Photo evidence attached successfully'
          : 'Photo evidence removed',
    ));
  }

  Future<void> _onSubmitDeliveryIssueReport(
    SubmitDeliveryIssueReportEvent event,
    Emitter<DeliveryIssueReportState> emit,
  ) async {
    emit(state.copyWith(status: IssueReportStatus.submitting));

    // Simulate luxury API network delay
    await Future.delayed(const Duration(milliseconds: 700));

    emit(state.copyWith(
      status: IssueReportStatus.success,
      report: state.report.copyWith(isSubmitted: true),
      feedbackMessage:
          'Issue reported for order ${state.report.orderId}. Support team alerted.',
    ));
  }
}
