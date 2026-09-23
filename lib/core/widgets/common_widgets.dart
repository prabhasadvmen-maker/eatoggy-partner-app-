import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_spacing.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final int? ratingCount;
  final double iconSize;

  const RatingWidget({
    super.key,
    required this.rating,
    this.ratingCount,
    this.iconSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: const BoxDecoration(
        color: AppColors.success,
        borderRadius: AppRadius.borderSm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            rating.toStringAsFixed(1),
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textLight,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 3),
          Icon(
            Icons.star,
            size: iconSize,
            color: AppColors.textLight,
          ),
          if (ratingCount != null) ...[
            const SizedBox(width: 4),
            Text(
              '($ratingCount)',
              style: AppTextStyles.caption.copyWith(color: AppColors.textLight),
            ),
          ]
        ],
      ),
    );
  }
}

class PriceWidget extends StatelessWidget {
  final double price;
  final double? originalPrice;
  final TextStyle? priceStyle;

  const PriceWidget({
    super.key,
    required this.price,
    this.originalPrice,
    this.priceStyle,
  });

  @override
  Widget build(BuildContext context) {
    final style = priceStyle ?? AppTextStyles.titleLarge;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text('₹${price.toInt()}', style: style),
        if (originalPrice != null && originalPrice! > price) ...[
          const SizedBox(width: 6),
          Text(
            '₹${originalPrice!.toInt()}',
            style: AppTextStyles.bodySmall.copyWith(
              decoration: TextDecoration.lineThrough,
              color: AppColors.textMuted,
            ),
          ),
        ]
      ],
    );
  }
}

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    if (quantity == 0) {
      return InkWell(
        onTap: onIncrement,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            border: Border.all(color: AppColors.primary, width: 1.2),
            borderRadius: AppRadius.borderMd,
          ),
          child: Text(
            'ADD',
            style: AppTextStyles.button.copyWith(
              color: AppColors.primary,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: AppRadius.borderMd,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 16, color: AppColors.textLight),
            onPressed: onDecrement,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            padding: EdgeInsets.zero,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              quantity.toString(),
              style: AppTextStyles.titleMedium.copyWith(color: AppColors.textLight),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 16, color: AppColors.textLight),
            onPressed: onIncrement,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
