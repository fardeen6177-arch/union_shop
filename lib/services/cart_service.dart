// lib/services/cart_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';
import '../utils/constants.dart';

class CartService {
  List<CartItem> _items = [];
  
  List<CartItem> get items => List.unmodifiable(_items);
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  bool get isEmpty => _items.isEmpty;
  bool get isNotEmpty => _items.isNotEmpty;

  /// Calculate subtotal
  double getSubtotal() {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  /// Calculate tax
  double getTax() {
    return getSubtotal() * AppConstants.taxRate;
  }

  /// Calculate total
  double getTotal() {
    return getSubtotal() + getTax();
  }

  /// Load cart from local storage
  Future<void> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? cartData = prefs.getString(AppConstants.cartStorageKey);
      
      if (cartData != null) {
        final List<dynamic> jsonData = json.decode(cartData);
        _items = jsonData.map((json) => CartItem.fromJson(json)).toList();
      }
    } catch (e) {
      // If loading fails, start with empty cart
      _items = [];
    }
  }

  /// Save cart to local storage
  Future<void> saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String cartData = json.encode(
        _items.map((item) => item.toJson()).toList(),
      );
      await prefs.setString(AppConstants.cartStorageKey, cartData);
    } catch (e) {
      throw Exception('Failed to save cart: $e');
    }
  }

  /// Add item to cart or update quantity if exists
  Future<void> addToCart(CartItem item) async {
    final existingIndex = _items.indexWhere(
      (cartItem) =>
          cartItem.productId == item.productId &&
          _areOptionsEqual(cartItem.selectedOptions, item.selectedOptions),
    );

    if (existingIndex >= 0) {
      // Update existing item quantity
      final newQuantity = _items[existingIndex].quantity + item.quantity;
      if (newQuantity <= AppConstants.maxCartQuantity) {
        _items[existingIndex].quantity = newQuantity;
      } else {
        throw Exception('Maximum quantity (${AppConstants.maxCartQuantity}) reached for this item');
      }
    } else {
      // Add new item
      _items.add(item);
    }

    await saveCart();
  }

  /// Remove item from cart
  Future<void> removeFromCart(String cartItemId) async {
    _items.removeWhere((item) => item.id == cartItemId);
    await saveCart();
  }

  /// Update item quantity
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

  /// Clear all items from cart
  Future<void> clearCart() async {
    _items = [];
    await saveCart();
  }

  /// Helper to compare option maps
  bool _areOptionsEqual(Map<String, String> options1, Map<String, String> options2) {
    if (options1.length != options2.length) return false;
    
    for (final key in options1.keys) {
      if (options1[key] != options2[key]) return false;
    }
    
    return true;
  }
}
