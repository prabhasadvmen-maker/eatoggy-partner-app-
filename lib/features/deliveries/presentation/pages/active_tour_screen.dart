import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../bloc/active_tour/active_tour_bloc.dart';
import '../../bloc/active_tour/active_tour_event.dart';
import '../../bloc/active_tour/active_tour_state.dart';
import '../widgets/tour_estimated_time_card.dart';
import '../widgets/tour_delivery_for_card.dart';
import 'verification_protocol_screen.dart';
import 'customer_call_screen.dart';

class ActiveTourScreen extends StatelessWidget {
  final String orderId;

  const ActiveTourScreen({
    super.key,
    this.orderId = '#EG-7840',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ActiveTourBloc()..add(LoadActiveTourEvent(orderId)),
      child: const ActiveTourView(),
    );
  }
}

class ActiveTourView extends StatelessWidget {
  const ActiveTourView({super.key});

  void _showCompletionDialog(BuildContext context) {
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
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: AppColors.successLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: AppColors.successText,
                size: 36,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Delivery Completed!',
              style: GoogleFonts.fraunces(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Order #EG-7840 has been handed over and confirmed.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppRadius.borderLg,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(dialogContext); // close dialog
                  Navigator.of(context).popUntil((route) => route.isFirst); // back to home
                },
                child: Text(
                  'Back to Dashboard',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.5,
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
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: BlocConsumer<ActiveTourBloc, ActiveTourState>(
          listener: (context, state) {
            if (state.status == ActiveTourStatus.otpVerified) {
              _showCompletionDialog(context);
            } else if (state.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          builder: (context, state) {
            final tour = state.tourData;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back arrow
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.border,
                            width: 1,
                          ),
                          boxShadow: AppShadows.card,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.textPrimary,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Title: Active Delivery Tour
                    Text(
                      tour.title,
                      style: GoogleFonts.fraunces(
                        color: AppColors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Subtitle: Out for Delivery • Order #EG-7840
                    Text(
                      tour.statusText,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 13.5,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Estimated Time Card
                    TourEstimatedTimeCard(
                      estimatedTimeLeft: tour.estimatedTimeLeft,
                      onClose: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(height: 14),

                    // Delivery For Card
                    TourDeliveryForCard(
                      customerName: tour.customerName,
                      address: tour.address,
                      gateAccessCode: tour.gateAccessCode,
                    ),

                    const Spacer(),

                    // Button 1: Enter Delivery OTP (Crimson CTA)
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: tour.isDelivered
                            ? null
                            : () async {
                                final result = await Navigator.push<bool>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => VerificationProtocolScreen(
                                      orderId: tour.orderId,
                                    ),
                                  ),
                                );
                                if (result == true && context.mounted) {
                                  context
                                      .read<ActiveTourBloc>()
                                      .add(VerifyOtpEvent(tour.correctOtp));
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tour.isDelivered
                              ? AppColors.success
                              : AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: AppRadius.borderLg,
                          ),
                        ),
                        child: Text(
                          tour.isDelivered
                              ? 'Delivery Completed ✓'
                              : 'Enter Delivery OTP',
                          style: GoogleFonts.inter(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Button 2: Initiate Customer Call (Outlined Button)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CustomerCallScreen(
                                orderId: tour.orderId,
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textPrimary,
                          side: const BorderSide(color: AppColors.border),
                          shape: const RoundedRectangleBorder(
                            borderRadius: AppRadius.borderLg,
                          ),
                        ),
                        child: Text(
                          'Initiate Customer Call',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
