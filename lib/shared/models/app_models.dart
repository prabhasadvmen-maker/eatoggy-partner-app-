import 'package:equatable/equatable.dart';

class FoodItem extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final bool isVeg;
  final double rating;
  final int ratingCount;
  final String category;
  final bool isBestseller;

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.isVeg,
    required this.rating,
    required this.ratingCount,
    required this.category,
    this.isBestseller = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        originalPrice,
        imageUrl,
        isVeg,
        rating,
        ratingCount,
        category,
        isBestseller,
      ];
}

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final int ratingCount;
  final String deliveryTime;
  final double deliveryFee;
  final List<String> cuisines;
  final String location;
  final String offerTag;
  final bool isPromoted;

  const Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.ratingCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.cuisines,
    required this.location,
    required this.offerTag,
    this.isPromoted = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        rating,
        ratingCount,
        deliveryTime,
        deliveryFee,
        cuisines,
        location,
        offerTag,
        isPromoted,
      ];
}

class CategoryItem extends Equatable {
  final String id;
  final String name;
  final String imageUrl;

  const CategoryItem({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, imageUrl];
}

class CartItem extends Equatable {
  final FoodItem foodItem;
  final int quantity;
  final String? instructions;

  const CartItem({
    required this.foodItem,
    required this.quantity,
    this.instructions,
  });

  double get totalPrice => foodItem.price * quantity;

  CartItem copyWith({
    FoodItem? foodItem,
    int? quantity,
    String? instructions,
  }) {
    return CartItem(
      foodItem: foodItem ?? this.foodItem,
      quantity: quantity ?? this.quantity,
      instructions: instructions ?? this.instructions,
    );
  }

  @override
  List<Object?> get props => [foodItem, quantity, instructions];
}

enum OrderStatus {
  placed,
  confirmed,
  preparing,
  outForDelivery,
  delivered,
  cancelled,
}

class OrderModel extends Equatable {
  final String orderId;
  final String restaurantName;
  final String restaurantImage;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime orderTime;
  final OrderStatus status;

  const OrderModel({
    required this.orderId,
    required this.restaurantName,
    required this.restaurantImage,
    required this.items,
    required this.totalAmount,
    required this.orderTime,
    required this.status,
  });

  @override
  List<Object?> get props => [
        orderId,
        restaurantName,
        restaurantImage,
        items,
        totalAmount,
        orderTime,
        status,
      ];
}
