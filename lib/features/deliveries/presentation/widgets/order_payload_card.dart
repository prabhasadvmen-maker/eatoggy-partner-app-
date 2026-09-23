import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/delivery_details_model.dart';

class OrderPayloadCard extends StatelessWidget {
  final String payloadTitle;
  final String packagesCount;
  final String timeSlot;
  final List<OrderItemModel> items;
  final int totalItems;
  final String deliveryNotes;

  const OrderPayloadCard({
    super.key,
    required this.payloadTitle,
    required this.packagesCount,
    required this.timeSlot,
    required this.items,
    required this.totalItems,
    required this.deliveryNotes,
  });

  @override
  Widget build(BuildContext context) {
    const goldColor = AppColors.cardGoldAccent;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF262628),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header: ORDER PAYLOAD & SLOT
          Text(
            'ORDER PAYLOAD & SLOT',
            style: GoogleFonts.inter(
              color: goldColor,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),

          // Payload Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                payloadTitle,
                style: GoogleFonts.inter(
                  color: const Color(0xFF8E8E93),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                packagesCount,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Time Slot Allocation Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Time Slot Allocation',
                style: GoogleFonts.inter(
                  color: const Color(0xFF8E8E93),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                timeSlot,
                style: GoogleFonts.inter(
                  color: goldColor,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFF262628),
            ),
          ),

          // Section Header: ORDER ITEMS
          Text(
            'ORDER ITEMS',
            style: GoogleFonts.inter(
              color: goldColor,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),

          // Order Items List
          ...items.map((item) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.name,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'x${item.quantity}',
                        style: GoogleFonts.inter(
                          color: goldColor,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                  thickness: 0.8,
                  color: Color(0xFF222226),
                ),
              ],
            );
          }),
          const SizedBox(height: 10),

          // Total Items Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Items:',
                style: GoogleFonts.inter(
                  color: const Color(0xFF8E8E93),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '$totalItems',
                style: GoogleFonts.inter(
                  color: goldColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Delivery Notes
          Text(
            'Delivery Notes:',
            style: GoogleFonts.inter(
              color: const Color(0xFF8E8E93),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            deliveryNotes,
            style: GoogleFonts.inter(
              color: const Color(0xFFCCCCCC),
              fontSize: 13.5,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
