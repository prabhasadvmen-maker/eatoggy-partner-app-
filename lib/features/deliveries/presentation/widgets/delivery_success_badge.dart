import 'package:flutter/material.dart';

class DeliverySuccessBadge extends StatelessWidget {
  const DeliverySuccessBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      height: 112,
      decoration: BoxDecoration(
        color: const Color(0xFF141A16),
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF00E676),
          width: 3.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00E676).withValues(alpha: 0.28),
            blurRadius: 28,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.check_rounded,
          color: Color(0xFF00E676),
          size: 52,
        ),
      ),
    );
  }
}
