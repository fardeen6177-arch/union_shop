// lib/services/cart_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';
import '../utils/constants.dart';

class CartService {
  // 1. Singleton Implementation: Ensures only one instance exists application-wide.
  static final CartService _instance = CartService._internal();

  factory CartService() {
    return _instance;
  }

  // Private named constructor
  CartService._internal();
  // End Singleton

  List<CartItem> _items = [];

  // --- Cart Data Getters ---

  /// Returns an unmodifiable list of cart items.
  List<CartItem> get items => List.unmodifiable(_items);

  /// Returns the total count of all items (sum of quantities).
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  /// Returns true if the cart is empty.
  bool get isEmpty => _items.isEmpty;

  /// Returns true if the cart is not empty.
  bool get isNotEmpty => _items.isNotEmpty;

  // --- Price Calculations ---

  /// Calculate subtotal (sum of all item total prices).
  double getSubtotal() {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  /// Calculate tax based on subtotal and AppConstants.taxRate.
  double getTax() {
    return getSubtotal() * AppConstants.taxRate;
  }

  /// Calculate total price (Subtotal + Tax).
  double getTotal() {
    return getSubtotal() + getTax();
  }

  // --- Local Storage Management ---

  /// Load cart from local storage (SharedPreferences).
  Future<void> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? cartData = prefs.getString(AppConstants.cartStorageKey);

      if (cartData != null) {
        final List<dynamic> jsonData = json.decode(cartData);
        _items = jsonData.map((json) => CartItem.fromJson(json)).toList();
      }
    } catch (e) {
      // In a real app, you might log this error.
      print('Error loading cart: $e'); 
      _items = [];
    }
  }

  /// Save cart to local storage (SharedPreferences).
  Future<void> saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String cartData = json.encode(
        _items.map((item) => item.toJson()).toList(),
      );
      await prefs.setString(AppConstants.cartStorageKey, cartData);
    } catch (e) {
      // Throw a specific exception to indicate storage failure
      throw Exception('Failed to save cart: $e');
    }
  }

  // --- Cart Mutators ---

  /// Add item to cart or update quantity if an equivalent item exists.
  Future<void> addToCart(CartItem item) async {
    final existingIndex = _items.indexWhere(
      (cartItem) =>
          cartItem.productId == item.productId &&
          _areOptionsEqual(cartItem.selectedOptions, item.selectedOptions),
    );

    if (existingIndex >= 0) {
      // Update existing item quantity
      final existingItem = _items[existingIndex];
      final newQuantity = existingItem.quantity + item.quantity;
      if (newQuantity <= AppConstants.maxCartQuantity) {
        existingItem.quantity = newQuantity;
      } else {
        throw Exception(
            'Maximum quantity (${AppConstants.maxCartQuantity}) reached for this item');
      }
    } else {
      // Add new item
      _items.add(item);
    }

    await saveCart();
  }

  /// Remove item from cart using its unique cartItemId.
  Future<void> removeFromCart(String cartItemId) async {
    _items.removeWhere((item) => item.id == cartItemId);
    await saveCart();
  }

  /// Update item quantity using its unique cartItemId.
  Future<void> updateQuantity(String cartItemId, int newQuantity) async {
    if (newQuantity < 1) {
      throw Exception('Quantity must be at least 1');
    }
    if (newQuantity > AppConstants.maxCartQuantity) {
      throw Exception('Quantity cannot exceed ${AppConstants.maxCartQuantity}');
    }

    final index = _items.indexWhere((item) => item.id == cartItemId);
    if (index >= 0) {
      _items[index].quantity = newQuantity;
      await saveCart();
    }
  }

  /// Clear all items from cart and update storage.
  Future<void> clearCart() async {
    _items = [];
    await saveCart();
  }

  // --- Helper Methods ---

  /// Helper to compare option maps for item equivalence.
  bool _areOptionsEqual(
      Map<String, String> options1, Map<String, String> options2) {
    if (options1.length != options2.length) return false;

    // Compares keys and values. Maps are equal if they have the same length
    // and every key in the first map matches the key/value in the second map.
    for (final key in options1.keys) {
      if (options1[key] != options2[key]) return false;
    }

    return true;
  }
}