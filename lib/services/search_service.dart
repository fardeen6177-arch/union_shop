// lib/services/search_service.dart
import '../models/product.dart';

enum SortOption {
  priceAsc,
  priceDesc,
  nameAsc,
  nameDesc,
  newest,
}

class SearchService {
  /// Filter products by price range
  List<Product> filterByPriceRange(
    List<Product> products,
    double? minPrice,
    double? maxPrice,
  ) {
    return products.where((product) {
      final price = product.effectivePrice;
      if (minPrice != null && price < minPrice) return false;
      if (maxPrice != null && price > maxPrice) return false;
      return true;
    }).toList();
  }

  /// Filter products by collection
  List<Product> filterByCollection(
    List<Product> products,
    String? collectionId,
  ) {
    if (collectionId == null || collectionId.isEmpty) {
      return products;
    }
    return products.where((p) => p.collectionId == collectionId).toList();
  }

  /// Filter products by tags
  List<Product> filterByTags(
    List<Product> products,
    List<String> tags,
  ) {
    if (tags.isEmpty) return products;
    
    return products.where((product) {
      return tags.any((tag) => product.tags.contains(tag));
    }).toList();
  }

  /// Filter products by stock availability
  List<Product> filterInStock(List<Product> products) {
    return products.where((p) => p.isInStock).toList();
  }

  /// Sort products
  List<Product> sortProducts(List<Product> products, SortOption option) {
    final sorted = List<Product>.from(products);

    switch (option) {
      case SortOption.priceAsc:
        sorted.sort((a, b) => a.effectivePrice.compareTo(b.effectivePrice));
        break;
      case SortOption.priceDesc:
        sorted.sort((a, b) => b.effectivePrice.compareTo(a.effectivePrice));
        break;
      case SortOption.nameAsc:
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortOption.nameDesc:
        sorted.sort((a, b) => b.name.compareTo(a.name));
        break;
      case SortOption.newest:
        // For mock data, we'll use product ID as proxy for newness
        sorted.sort((a, b) => b.id.compareTo(a.id));
        break;
    }

    return sorted;
  }

  /// Apply multiple filters and sorting
  List<Product> applyFiltersAndSort({
    required List<Product> products,
    String? searchQuery,
    double? minPrice,
    double? maxPrice,
    String? collectionId,
    List<String>? tags,
    bool onlyInStock = false,
    SortOption sortOption = SortOption.nameAsc,
  }) {
    var filtered = products;

    // Apply search query
    if (searchQuery != null && searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered.where((p) {
        return p.name.toLowerCase().contains(query) ||
            p.description.toLowerCase().contains(query) ||
            p.tags.any((tag) => tag.toLowerCase().contains(query));
      }).toList();
    }

    // Apply price filter
    filtered = filterByPriceRange(filtered, minPrice, maxPrice);

    // Apply collection filter
    filtered = filterByCollection(filtered, collectionId);

    // Apply tags filter
    if (tags != null && tags.isNotEmpty) {
      filtered = filterByTags(filtered, tags);
    }

    // Apply stock filter
    if (onlyInStock) {
      filtered = filterInStock(filtered);
    }

    // Apply sorting
    filtered = sortProducts(filtered, sortOption);

    return filtered;
  }
}
