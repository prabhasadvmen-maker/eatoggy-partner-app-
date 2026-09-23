import '../models/app_models.dart';

class MockData {
  MockData._();

  static const List<CategoryItem> categories = [
    CategoryItem(
      id: 'cat_1',
      name: 'Biryani',
      imageUrl: 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=300',
    ),
    CategoryItem(
      id: 'cat_2',
      name: 'Pizza',
      imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=300',
    ),
    CategoryItem(
      id: 'cat_3',
      name: 'Burger',
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300',
    ),
    CategoryItem(
      id: 'cat_4',
      name: 'Chinese',
      imageUrl: 'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=300',
    ),
    CategoryItem(
      id: 'cat_5',
      name: 'Desserts',
      imageUrl: 'https://images.unsplash.com/photo-1551024709-8f23befc6f87?w=300',
    ),
    CategoryItem(
      id: 'cat_6',
      name: 'Rolls',
      imageUrl: 'https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?w=300',
    ),
  ];

  static const List<Restaurant> restaurants = [
    Restaurant(
      id: 'rest_1',
      name: 'Royal Biryani House',
      imageUrl: 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=600',
      rating: 4.5,
      ratingCount: 1200,
      deliveryTime: '25-30 min',
      deliveryFee: 35.0,
      cuisines: ['Biryani', 'North Indian', 'Mughlai'],
      location: 'Connaught Place, New Delhi',
      offerTag: '60% OFF up to ₹120',
      isPromoted: true,
    ),
    Restaurant(
      id: 'rest_2',
      name: 'Pizza Express & Kitchen',
      imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=600',
      rating: 4.3,
      ratingCount: 850,
      deliveryTime: '30-35 min',
      deliveryFee: 40.0,
      cuisines: ['Italian', 'Pizzas', 'Fast Food'],
      location: 'Cyber Hub, Gurugram',
      offerTag: 'EVERYTHING AT ₹199',
      isPromoted: false,
    ),
    Restaurant(
      id: 'rest_3',
      name: 'Burger & Shake Co.',
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600',
      rating: 4.6,
      ratingCount: 2100,
      deliveryTime: '20-25 min',
      deliveryFee: 25.0,
      cuisines: ['Burgers', 'American', 'Beverages'],
      location: 'Sector 18, Noida',
      offerTag: 'Free Delivery',
      isPromoted: true,
    ),
    Restaurant(
      id: 'rest_4',
      name: 'Wok & Roll Asian Bistro',
      imageUrl: 'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=600',
      rating: 4.2,
      ratingCount: 640,
      deliveryTime: '35-40 min',
      deliveryFee: 45.0,
      cuisines: ['Chinese', 'Thai', 'Pan-Asian'],
      location: 'Hauz Khas Village, New Delhi',
      offerTag: '20% OFF',
      isPromoted: false,
    ),
  ];

  static const List<FoodItem> foodItems = [
    FoodItem(
      id: 'food_1',
      name: 'Hyderabadi Chicken Dum Biryani',
      description: 'Richly spiced chicken layered with fragrant basmati rice and saffron caramelised onions.',
      price: 289.0,
      originalPrice: 349.0,
      imageUrl: 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=500',
      isVeg: false,
      rating: 4.7,
      ratingCount: 430,
      category: 'Biryani',
      isBestseller: true,
    ),
    FoodItem(
      id: 'food_2',
      name: 'Paneer Butter Masala Combo',
      description: 'Creamy cottage cheese gravy served with 2 Butter Naans and Jeera Rice.',
      price: 249.0,
      originalPrice: 299.0,
      imageUrl: 'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=500',
      isVeg: true,
      rating: 4.5,
      ratingCount: 290,
      category: 'Main Course',
      isBestseller: true,
    ),
    FoodItem(
      id: 'food_3',
      name: 'Cheesy Supreme Pizza (10 inch)',
      description: 'Loaded with mozzarella, cheddar, bell peppers, olives, and jalapenos.',
      price: 399.0,
      originalPrice: 499.0,
      imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500',
      isVeg: true,
      rating: 4.6,
      ratingCount: 510,
      category: 'Pizza',
      isBestseller: false,
    ),
    FoodItem(
      id: 'food_4',
      name: 'Crispy Zinger Chicken Burger',
      description: 'Double fried chicken thigh fillet with peri-peri mayo and fresh iceberg lettuce.',
      price: 189.0,
      originalPrice: 229.0,
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500',
      isVeg: false,
      rating: 4.4,
      ratingCount: 180,
      category: 'Burger',
      isBestseller: true,
    ),
  ];

  static List<OrderModel> get sampleOrders => [
        OrderModel(
          orderId: 'EATG-98421',
          restaurantName: 'Royal Biryani House',
          restaurantImage: 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=300',
          items: const [
            CartItem(
              foodItem: FoodItem(
                id: 'food_1',
                name: 'Hyderabadi Chicken Dum Biryani',
                description: 'Spiced chicken layered with fragrant basmati rice.',
                price: 289.0,
                imageUrl: 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=500',
                isVeg: false,
                rating: 4.7,
                ratingCount: 430,
                category: 'Biryani',
              ),
              quantity: 2,
            ),
          ],
          totalAmount: 613.0,
          orderTime: DateTime.now().subtract(const Duration(minutes: 25)),
          status: OrderStatus.preparing,
        ),
        OrderModel(
          orderId: 'EATG-91204',
          restaurantName: 'Pizza Express & Kitchen',
          restaurantImage: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=300',
          items: const [
            CartItem(
              foodItem: FoodItem(
                id: 'food_3',
                name: 'Cheesy Supreme Pizza (10 inch)',
                description: 'Loaded with mozzarella.',
                price: 399.0,
                imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500',
                isVeg: true,
                rating: 4.6,
                ratingCount: 510,
                category: 'Pizza',
              ),
              quantity: 1,
            ),
          ],
          totalAmount: 434.0,
          orderTime: DateTime.now().subtract(const Duration(days: 2)),
          status: OrderStatus.delivered,
        ),
      ];
}
