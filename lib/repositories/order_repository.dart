// lib/repositories/order_repository.dart

/// Repository class for managing order quantity
class OrderRepository {
  final int maxQuantity;
  int _quantity = 0;

  /// Creates an OrderRepository with a specified maximum quantity limit
  OrderRepository({required this.maxQuantity});

  /// Gets the current quantity
  int get quantity => _quantity;

  /// Increments the quantity by 1, but not exceeding maxQuantity
  void increment() {
    if (_quantity < maxQuantity) {
      _quantity++;
    }
  }

  /// Decrements the quantity by 1, but not going below 0
  void decrement() {
    if (_quantity > 0) {
      _quantity--;
    }
  }
}
