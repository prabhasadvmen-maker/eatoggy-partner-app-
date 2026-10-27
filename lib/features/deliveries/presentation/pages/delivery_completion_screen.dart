import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../bloc/delivery_completion/delivery_completion_bloc.dart';
import '../../bloc/delivery_completion/delivery_completion_event.dart';
import '../../bloc/delivery_completion/delivery_completion_state.dart';
import '../widgets/delivery_completion_card.dart';
import '../widgets/delivery_success_badge.dart';
import '../../../earnings/presentation/widgets/customer_tip_celebration_modal.dart';

class DeliveryCompletionScreen extends StatelessWidget {
  final String orderId;

  const DeliveryCompletionScreen({
    super.key,
    this.orderId = '#EG-7840',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeliveryCompletionBloc(orderId: orderId)
        ..add(LoadDeliveryCompletionEvent(orderId)),
      child: const DeliveryCompletionView(),
    );
  }
}

class DeliveryCompletionView extends StatelessWidget {
  const DeliveryCompletionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCompletionBloc, DeliveryCompletionState>(
      listener: (context, state) {
        if (state.status == DeliveryCompletionStatus.backToDashboard) {
          Navigator.popUntil(context, (route) => route.isFirst);
        } else if (state.status == DeliveryCompletionStatus.nextDelivery) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      },
      builder: (context, state) {
        final data = state.data;

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  const SizedBox(height: 32),

                  // Top Centered Success Badge
                  const Center(
                    child: DeliverySuccessBadge(),
                  ),
                  const SizedBox(height: 24),

                  // Title: "Delivery Completed!"
                  Text(
                    data.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.fraunces(
                      color: AppColors.textPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle: "Luxurious service successfully rendered to client"
                  Text(
                    data.subtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Summary Card
                  DeliveryCompletionCard(model: data),
                  const SizedBox(height: 16),

                  // Customer Tip Banner
                  GestureDetector(
                    onTap: () => CustomerTipCelebrationModal.show(
                      context,
                      customerName: data.customerName,
                      orderId: data.orderId,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFFBEB), Color(0xFFFEF3C7)],
                        ),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFFDE68A)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.favorite_rounded,
                            color: Color(0xFFD97706),
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Customer included a ₹50.00 Tip! Tap to thank.',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF92400E),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Color(0xFFD97706),
                            size: 13,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Button 1: "Next Delivery" (Gourmet Crimson Button)
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<DeliveryCompletionBloc>()
                            .add(const NextDeliveryTappedEvent());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: AppRadius.borderLg,
                        ),
                      ),
                      child: Text(
                        'Next Delivery',
                        style: GoogleFonts.inter(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Button 2: "Back to Dashboard"
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context
                            .read<DeliveryCompletionBloc>()
                            .add(const BackToDashboardTappedEvent());
                      },
                      child: Text(
                        'Back to Dashboard',
                        style: GoogleFonts.inter(
                          color: AppColors.textPrimary,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
