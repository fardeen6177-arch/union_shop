// lib/providers/cart_provider.dart
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../services/cart_service.dart';

class CartProvider with ChangeNotifier {
  final CartService _cartService = CartService();
  bool _isInitialized = false;

  List<CartItem> get items => _cartService.items;
  int get itemCount => _cartService.itemCount;
  bool get isEmpty => _cartService.isEmpty;
  bool get isNotEmpty => _cartService.isNotEmpty;
  double get subtotal => _cartService.getSubtotal();
  double get tax => _cartService.getTax();
  double get total => _cartService.getTotal();

  /// Initialize cart (load from storage)
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _cartService.loadCart();
    _isInitialized = true;
    notifyListeners();
  }

  /// Add product to cart
  Future<void> addToCart({
    required Product product,
    required Map<String, String> selectedOptions,
    int quantity = 1,
  }) async {
    try {
      final cartItem = CartItem(
        id: const Uuid().v4(),
        productId: product.id,
        quantity: quantity,
        selectedOptions: selectedOptions,
        unitPrice: product.effectivePrice,
        productName: product.name,
        productImage: product.images.isNotEmpty ? product.images[0] : '',
      );

      await _cartService.addToCart(cartItem);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  /// Remove item from cart
  Future<void> removeItem(String cartItemId) async {
    try {
      await _cartService.removeFromCart(cartItemId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  /// Update item quantity
  Future<void> updateQuantity(String cartItemId, int newQuantity) async {
    try {
      await _cartService.updateQuantity(cartItemId, newQuantity);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  /// Increment item quantity
  Future<void> incrementQuantity(String cartItemId) async {
    final item = items.firstWhere((i) => i.id == cartItemId);
    await updateQuantity(cartItemId, item.quantity + 1);
  }

  /// Decrement item quantity
  Future<void> decrementQuantity(String cartItemId) async {
    final item = items.firstWhere((i) => i.id == cartItemId);
    if (item.quantity > 1) {
      await updateQuantity(cartItemId, item.quantity - 1);
    }
  }

  /// Clear cart
  Future<void> clearCart() async {
    try {
      await _cartService.clearCart();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
