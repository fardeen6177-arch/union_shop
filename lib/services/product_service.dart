// lib/services/product_service.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';

class ProductService {
  List<Product>? _cachedProducts;

  /// Load all products from local JSON
  Future<List<Product>> getProducts() async {
    if (_cachedProducts != null) {
      return _cachedProducts!;
    }

    try {
      final String response = await rootBundle.loadString('assets/data/products.json');
      final List<dynamic> data = json.decode(response);
      _cachedProducts = data.map((json) => Product.fromJson(json)).toList();
      return _cachedProducts!;
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  /// Get single product by ID
  Future<Product?> getProductById(String id) async {
    final products = await getProducts();
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get products by collection ID
  Future<List<Product>> getProductsByCollection(String collectionId) async {
    final products = await getProducts();
    return products.where((p) => p.collectionId == collectionId).toList();
  }

  /// Get sale products (products with salePrice)
  Future<List<Product>> getSaleProducts() async {
    final products = await getProducts();
    return products.where((p) => p.isOnSale).toList();
  }

  /// Get products by tag
  Future<List<Product>> getProductsByTag(String tag) async {
    final products = await getProducts();
    return products.where((p) => p.tags.contains(tag)).toList();
  }

  /// Search products by name or description
  Future<List<Product>> searchProducts(String query) async {
    if (query.trim().isEmpty) {
      return await getProducts();
    }

    final products = await getProducts();
    final lowerQuery = query.toLowerCase();
    
    return products.where((p) {
      return p.name.toLowerCase().contains(lowerQuery) ||
          p.description.toLowerCase().contains(lowerQuery) ||
          p.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }

  /// Clear cache (useful for testing)
  void clearCache() {
    _cachedProducts = null;
  }
}
