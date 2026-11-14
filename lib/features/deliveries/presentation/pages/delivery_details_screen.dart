import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../bloc/delivery_details/delivery_details_bloc.dart';
import '../../bloc/delivery_details/delivery_details_event.dart';
import '../../bloc/delivery_details/delivery_details_state.dart';
import '../widgets/customer_location_card.dart';
import '../widgets/order_payload_card.dart';
import 'active_navigation_screen.dart';
import 'customer_call_screen.dart';
import 'customer_chat_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.textPrimary,
            size: 18,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Text(
          'Delivery Details',
          style: GoogleFonts.fraunces(
            color: AppColors.textPrimary,
            fontSize: 20,
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
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(color: AppColors.border, height: 1),
        ),
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
                    vertical: 14,
                  ),
                  child: Column(
                    children: [
                      // Customer & Delivery Location Card
                      CustomerLocationCard(
                        customerName: details.customerName,
                        subscriptionType: details.subscriptionType,
                        address: details.deliveryLocation,
                        onCall: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomerCallScreen(
                                orderId: details.orderId,
                              ),
                            ),
                          );
                        },
                        onChat: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomerChatScreen(
                                customerName: details.customerName,
                                orderId: details.orderId,
                              ),
                            ),
                          );
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

              // Bottom Action Buttons
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(
                    top: BorderSide(color: AppColors.border),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 20),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // "Confirm Pickup & Go" CTA Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: AppRadius.borderLg,
                            ),
                          ),
                          child: Text(
                            details.isPickupConfirmed
                                ? 'Pickup Confirmed ✓'
                                : 'Confirm Pickup & Go',
                            style: GoogleFonts.inter(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // "Message Customer" Secondary Outlined Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomerChatScreen(
                                  customerName: details.customerName,
                                  orderId: details.orderId,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.chat_outlined, size: 18),
                          label: Text(
                            'Message Customer',
                            style: GoogleFonts.inter(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textPrimary,
                            side: const BorderSide(color: AppColors.border),
                            shape: const RoundedRectangleBorder(
                              borderRadius: AppRadius.borderLg,
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
