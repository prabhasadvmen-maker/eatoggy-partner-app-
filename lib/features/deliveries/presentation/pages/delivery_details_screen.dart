import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/delivery_details/delivery_details_bloc.dart';
import '../../bloc/delivery_details/delivery_details_event.dart';
import '../../bloc/delivery_details/delivery_details_state.dart';
import '../widgets/customer_location_card.dart';
import '../widgets/order_payload_card.dart';
import 'active_navigation_screen.dart';

class DeliveryDetailsScreen extends StatelessWidget {
  final String orderId;

  const DeliveryDetailsScreen({
    super.key,
    this.orderId = '#EG-7840',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DeliveryDetailsBloc()..add(LoadDeliveryDetailsEvent(orderId)),
      child: const DeliveryDetailsView(),
    );
  }
}

class DeliveryDetailsView extends StatelessWidget {
  const DeliveryDetailsView({super.key});

  static const Color _screenBg = Color(0xFF111111);
  static const Color _goldColor = AppColors.cardGoldAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _screenBg,
      appBar: AppBar(
        backgroundColor: _screenBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: _goldColor,
            size: 24,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Text(
          'Delivery Details',
          style: GoogleFonts.fraunces(
            color: AppColors.creamText,
            fontSize: 21,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          BlocBuilder<DeliveryDetailsBloc, DeliveryDetailsState>(
            builder: (context, state) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: Text(
                    state.details.orderId,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF8E8E93),
                      fontSize: 14.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<DeliveryDetailsBloc, DeliveryDetailsState>(
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          final details = state.details;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  child: Column(
                    children: [
                      // Customer & Delivery Location Card
                      CustomerLocationCard(
                        customerName: details.customerName,
                        subscriptionType: details.subscriptionType,
                        address: details.deliveryLocation,
                        onCall: () {
                          context
                              .read<DeliveryDetailsBloc>()
                              .add(const CallCustomerEvent());
                        },
                        onCopyAddress: () {
                          context
                              .read<DeliveryDetailsBloc>()
                              .add(const CopyAddressEvent());
                        },
                      ),
                      const SizedBox(height: 16),

                      // Order Payload, Items, and Delivery Notes Card
                      OrderPayloadCard(
                        payloadTitle: details.payloadTitle,
                        packagesCount: details.packagesCount,
                        timeSlot: details.timeSlot,
                        items: details.items,
                        totalItems: details.totalItems,
                        deliveryNotes: details.deliveryNotes,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Bottom Action Buttons matching screenshot
              Container(
                color: _screenBg,
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // "Confirm Pickup & Go" Gold CTA Button
                      InkWell(
                        onTap: () {
                          context
                              .read<DeliveryDetailsBloc>()
                              .add(const ConfirmPickupEvent());
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ActiveNavigationScreen(
                                orderId: details.orderId,
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: double.infinity,
                          height: 52,
                          decoration: BoxDecoration(
                            color: _goldColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: _goldColor.withValues(alpha: 0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              details.isPickupConfirmed
                                  ? 'Pickup Confirmed ✓'
                                  : 'Confirm Pickup & Go',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF141416),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // "Call" Secondary Dark Button
                      InkWell(
                        onTap: () {
                          context
                              .read<DeliveryDetailsBloc>()
                              .add(const CallCustomerEvent());
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF18181A),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF2E2E32),
                              width: 1.2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Call',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
