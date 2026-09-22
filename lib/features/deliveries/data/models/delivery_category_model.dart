import 'package:flutter/material.dart';

class DeliveryCategoryModel {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;

  const DeliveryCategoryModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  static const List<DeliveryCategoryModel> sampleCategories = [
    DeliveryCategoryModel(
      id: 'todays_deliveries',
      title: "Today's Deliveries",
      subtitle: "View and manage your scheduled deliveries",
      icon: Icons.local_shipping_outlined,
    ),
    DeliveryCategoryModel(
      id: 'delivery_history',
      title: "Delivery History",
      subtitle: "Past deliveries and completed orders",
      icon: Icons.access_time_rounded,
    ),
    DeliveryCategoryModel(
      id: 'tiffin_zone',
      title: "Tiffin Zone",
      subtitle: "Your 10km tiffin subscriber area",
      icon: Icons.map_outlined,
    ),
    DeliveryCategoryModel(
      id: 'tiffin_subscribers',
      title: "Tiffin Subscribers",
      subtitle: "Manage your recurring tiffin customers",
      icon: Icons.group_outlined,
    ),
  ];
}
