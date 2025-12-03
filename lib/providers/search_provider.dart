// lib/providers/search_provider.dart
import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/search_service.dart';

class SearchProvider with ChangeNotifier {
  final SearchService _searchService = SearchService();

  String _searchQuery = '';
  double? _minPrice;
  double? _maxPrice;
  String? _selectedCollectionId;
  List<String> _selectedTags = [];
  bool _onlyInStock = false;
  SortOption _sortOption = SortOption.nameAsc;

  String get searchQuery => _searchQuery;
  double? get minPrice => _minPrice;
  double? get maxPrice => _maxPrice;
  String? get selectedCollectionId => _selectedCollectionId;
  List<String> get selectedTags => _selectedTags;
  bool get onlyInStock => _onlyInStock;
  SortOption get sortOption => _sortOption;

  /// Update search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  /// Update price range
  void setPriceRange(double? min, double? max) {
    _minPrice = min;
    _maxPrice = max;
    notifyListeners();
  }

  /// Update selected collection
  void setCollection(String? collectionId) {
    _selectedCollectionId = collectionId;
    notifyListeners();
  }

  /// Toggle tag selection
  void toggleTag(String tag) {
    if (_selectedTags.contains(tag)) {
      _selectedTags.remove(tag);
    } else {
      _selectedTags.add(tag);
    }
    notifyListeners();
  }

  /// Clear all tags
  void clearTags() {
    _selectedTags = [];
    notifyListeners();
  }

  /// Toggle in-stock filter
  void toggleInStock() {
    _onlyInStock = !_onlyInStock;
    notifyListeners();
  }

  /// Update sort option
  void setSortOption(SortOption option) {
    _sortOption = option;
    notifyListeners();
  }

  /// Apply filters and sorting to product list
  List<Product> applyFilters(List<Product> products) {
    return _searchService.applyFiltersAndSort(
      products: products,
      searchQuery: _searchQuery,
      minPrice: _minPrice,
      maxPrice: _maxPrice,
      collectionId: _selectedCollectionId,
      tags: _selectedTags.isNotEmpty ? _selectedTags : null,
      onlyInStock: _onlyInStock,
      sortOption: _sortOption,
    );
  }

  /// Reset all filters
  void resetFilters() {
    _searchQuery = '';
    _minPrice = null;
    _maxPrice = null;
    _selectedCollectionId = null;
    _selectedTags = [];
    _onlyInStock = false;
    _sortOption = SortOption.nameAsc;
    notifyListeners();
  }
}
