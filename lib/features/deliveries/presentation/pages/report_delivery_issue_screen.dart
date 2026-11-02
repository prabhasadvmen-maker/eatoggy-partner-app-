import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../bloc/delivery_issue_report/delivery_issue_report_bloc.dart';
import '../../bloc/delivery_issue_report/delivery_issue_report_event.dart';
import '../../bloc/delivery_issue_report/delivery_issue_report_state.dart';
import '../widgets/issue_reason_tile.dart';
import '../widgets/photo_evidence_box.dart';

class ReportDeliveryIssueScreen extends StatelessWidget {
  final String orderId;

  const ReportDeliveryIssueScreen({
    super.key,
    this.orderId = '#EG-7840',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeliveryIssueReportBloc(orderId: orderId)
        ..add(LoadDeliveryIssueReportEvent(orderId)),
      child: const ReportDeliveryIssueView(),
    );
  }
}

class ReportDeliveryIssueView extends StatefulWidget {
  const ReportDeliveryIssueView({super.key});

  @override
  State<ReportDeliveryIssueView> createState() =>
      _ReportDeliveryIssueViewState();
}

class _ReportDeliveryIssueViewState extends State<ReportDeliveryIssueView> {
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _showReportSuccessDialog(BuildContext context, String reason, String orderId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.borderLg,
          side: BorderSide(color: AppColors.border),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: AppColors.errorLight,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.error.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.assignment_late_outlined,
                color: AppColors.error,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Report Submitted',
              textAlign: TextAlign.center,
              style: GoogleFonts.fraunces(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Issue "$reason" logged for order $orderId. Fleet support will review and advise.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                fontSize: 13.5,
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppRadius.borderLg,
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pop(dialogContext); // Close dialog
                  Navigator.popUntil(context, (route) => route.isFirst); // Send user directly to dashboard
                },
                child: Text(
                  'Acknowledge & Close',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryIssueReportBloc, DeliveryIssueReportState>(
      listener: (context, state) {
        if (state.status == IssueReportStatus.success) {
          _showReportSuccessDialog(
            context,
            state.report.selectedReason,
            state.report.orderId,
          );
        }
      },
      builder: (context, state) {
        final report = state.report;

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(
            child: Column(
              children: [
                // Top back bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.border,
                              width: 1.0,
                            ),
                            boxShadow: AppShadows.card,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.textPrimary,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Form Body
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),

                        // Title: "Report Issue" (Fraunces Crimson)
                        Text(
                          'Report Issue',
                          style: GoogleFonts.fraunces(
                            color: AppColors.primary,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Subtitle: "Please specify the accurate reason for delivery failure"
                        Text(
                          'Please specify the accurate reason for delivery failure',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 14.5,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Selectable Reasons
                        ...report.availableReasons.map((reason) {
                          final isSelected = report.selectedReason == reason;
                          return IssueReasonTile(
                            title: reason,
                            isSelected: isSelected,
                            onTap: () {
                              context
                                  .read<DeliveryIssueReportBloc>()
                                  .add(SelectIssueReasonEvent(reason));
                            },
                          );
                        }),

                        const SizedBox(height: 16),

                        // Label: Additional Notes
                        Text(
                          'Additional Notes',
                          style: GoogleFonts.inter(
                            color: AppColors.textSecondary,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Input Box: Additional Notes
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: AppRadius.borderLg,
                            border: Border.all(
                              color: AppColors.border,
                              width: 1.0,
                            ),
                            boxShadow: AppShadows.card,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: TextField(
                            controller: _notesController,
                            maxLines: 4,
                            onChanged: (val) {
                              context
                                  .read<DeliveryIssueReportBloc>()
                                  .add(UpdateAdditionalNotesEvent(val));
                            },
                            style: GoogleFonts.inter(
                              color: AppColors.textPrimary,
                              fontSize: 14,
                              height: 1.4,
                            ),
                            decoration: InputDecoration(
                              filled: false,
                              hintText:
                                  "Type specific details here (e.g. gate code failed, client's phone switched off)...",
                              hintStyle: GoogleFonts.inter(
                                color: AppColors.textPlaceholder,
                                fontSize: 13,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Label: Photo Evidence (Optional)
                        Text(
                          'Photo Evidence (Optional)',
                          style: GoogleFonts.inter(
                            color: AppColors.textSecondary,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Photo Evidence Box
                        PhotoEvidenceBox(
                          imagePath: report.photoEvidencePath,
                          onImageSelected: (path) {
                            context
                                .read<DeliveryIssueReportBloc>()
                                .add(AttachPhotoEvidenceEvent(path));
                          },
                        ),

                        const SizedBox(height: 28),

                        // Crimson Submit Button: "Submit Report"
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: state.status == IssueReportStatus.submitting
                                ? null
                                : () {
                                    context
                                        .read<DeliveryIssueReportBloc>()
                                        .add(const SubmitDeliveryIssueReportEvent());
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                borderRadius: AppRadius.borderLg,
                              ),
                            ),
                            child: state.status == IssueReportStatus.submitting
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Submit Report',
                                    style: GoogleFonts.inter(
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
