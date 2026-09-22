import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
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
        backgroundColor: const Color(0xFF181816),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(color: Color(0xFF2E2E2A)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFE55353).withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFE55353).withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.assignment_late_outlined,
                color: Color(0xFFE55353),
                size: 34,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Report Submitted',
              textAlign: TextAlign.center,
              style: GoogleFonts.fraunces(
                color: AppColors.creamText,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Issue "$reason" logged for order $orderId. Fleet support will review and advise.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondaryDark,
                fontSize: 13.5,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cardGoldAccent,
                  foregroundColor: const Color(0xFF11110F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
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
                    color: const Color(0xFF11110F),
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
          backgroundColor: AppColors.darkBackground,
          body: SafeArea(
            child: Column(
              children: [
                // Top subtle back bar
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
                            color: const Color(0xFF1E1E1C),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF2E2E2A),
                              width: 1.0,
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.creamText,
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

                        // Title: "Report Issue" (Coral/Red Serif)
                        Text(
                          'Report Issue',
                          style: GoogleFonts.fraunces(
                            color: const Color(0xFFE55353),
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Subtitle: "Please specify the accurate reason for delivery failure"
                        Text(
                          'Please specify the accurate reason for delivery failure',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF8E8E93),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 28),

                        // 4 Selectable Reasons
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

                        const SizedBox(height: 18),

                        // Label: Additional Notes
                        Text(
                          'Additional Notes',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF8E8E93),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Input Box: Additional Notes
                        Container(
                          height: 110,
                          decoration: BoxDecoration(
                            color: const Color(0xFF161615),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF282826),
                              width: 1.0,
                            ),
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
                              color: AppColors.creamText,
                              fontSize: 14,
                              height: 1.4,
                            ),
                            decoration: const InputDecoration(
                              filled: false,
                              fillColor: Colors.transparent,
                              hintText:
                                  "Type specific details here (e.g. gate code failed, client's phone switched off)...",
                              hintStyle: TextStyle(
                                color: Color(0xFF52525B),
                                fontSize: 13.5,
                                height: 1.35,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        // Label: Photo Evidence (Optional)
                        Text(
                          'Photo Evidence (Optional)',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF8E8E93),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Photo Evidence Box
                        PhotoEvidenceBox(
                          imagePath: report.photoEvidencePath,
                          onImageSelected: (path) {
                            context
                                .read<DeliveryIssueReportBloc>()
                                .add(AttachPhotoEvidenceEvent(path));
                          },
                        ),

                        const SizedBox(height: 32),

                        // Gold Submit Button: "Submit Report"
                        InkWell(
                          onTap: state.status == IssueReportStatus.submitting
                              ? null
                              : () {
                                  context
                                      .read<DeliveryIssueReportBloc>()
                                      .add(const SubmitDeliveryIssueReportEvent());
                                },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFE8B669),
                                  Color(0xFFD69C45),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFD69C45).withValues(alpha: 0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: state.status == IssueReportStatus.submitting
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Color(0xFF11110F),
                                      ),
                                    )
                                  : Text(
                                      'Submit Report',
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF11110F),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.1,
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),
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
