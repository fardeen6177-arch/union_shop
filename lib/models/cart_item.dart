// lib/models/cart_item.dart
class CartItem {
  final String id;
  final String productId;
  int quantity;
  final Map<String, String> selectedOptions; // e.g., {"size": "M", "color": "Red"}
  final double unitPrice;
  final String productName;
  final String productImage;

  CartItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.selectedOptions,
    required this.unitPrice,
    required this.productName,
    required this.productImage,
  });

  double get totalPrice => unitPrice * quantity;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      productId: json['productId'] as String,
      quantity: json['quantity'] as int,
      selectedOptions: Map<String, String>.from(json['selectedOptions'] as Map),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      productName: json['productName'] as String,
      productImage: json['productImage'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'selectedOptions': selectedOptions,
      'unitPrice': unitPrice,
      'productName': productName,
      'productImage': productImage,
    };
  }

  CartItem copyWith({
    String? id,
    String? productId,
    int? quantity,
    Map<String, String>? selectedOptions,
    double? unitPrice,
    String? productName,
    String? productImage,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      unitPrice: unitPrice ?? this.unitPrice,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
    );
  }
}
