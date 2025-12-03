// lib/providers/product_provider.dart
import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../models/collection.dart';
import '../services/product_service.dart';
import '../services/collection_service.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();
  final CollectionService _collectionService = CollectionService();

  List<Product> _products = [];
  List<Collection> _collections = [];
  bool _isLoading = false;
  String? _error;

  List<Product> get products => _products;
  List<Collection> get collections => _collections;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Load products and collections
  Future<void> loadData() async {
    if (_products.isNotEmpty && _collections.isNotEmpty) {
      return; // Already loaded
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await _productService.getProducts();
      _collections = await _collectionService.getCollections();
      _error = null;
    } catch (e) {
      _error = 'Failed to load data: ${e.toString()}';
      _products = [];
      _collections = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Get product by ID
  Product? getProductById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get collection by ID
  Collection? getCollectionById(String id) {
    try {
      return _collections.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get products by collection
  List<Product> getProductsByCollection(String collectionId) {
    return _products.where((p) => p.collectionId == collectionId).toList();
  }

  /// Get sale products
  List<Product> getSaleProducts() {
    return _products.where((p) => p.isOnSale).toList();
  }

  /// Refresh data
  Future<void> refresh() async {
    _products = [];
    _collections = [];
    await loadData();
  }
}
