// lib/models/product.dart
class Product {
  final String id;
  final String name;
  final String sku;
  final String description;
  final double price;
  final double? salePrice;
  final List<String> images;
  final List<String> tags;
  final String collectionId;
  final Map<String, List<String>> options; // e.g., {"size": ["S", "M", "L"], "color": ["Red", "Blue"]}
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.description,
    required this.price,
    this.salePrice,
    required this.images,
    required this.tags,
    required this.collectionId,
    required this.options,
    required this.stock,
  });

  double get effectivePrice => salePrice ?? price;
  bool get isOnSale => salePrice != null && salePrice! < price;
  bool get isInStock => stock > 0;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      sku: json['sku'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      salePrice: json['salePrice'] != null ? (json['salePrice'] as num).toDouble() : null,
      images: List<String>.from(json['images'] as List),
      tags: List<String>.from(json['tags'] as List),
      collectionId: json['collectionId'] as String,
      options: Map<String, List<String>>.from(
        (json['options'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, List<String>.from(value as List)),
        ),
      ),
      stock: json['stock'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'description': description,
      'price': price,
      'salePrice': salePrice,
      'images': images,
      'tags': tags,
      'collectionId': collectionId,
      'options': options,
      'stock': stock,
    };
  }
}
