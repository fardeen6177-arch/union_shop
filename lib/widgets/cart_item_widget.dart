// lib/widgets/cart_item_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import '../config/theme.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: 80,
              height: 80,
              color: Colors.grey[200],
              child: item.productImage.isNotEmpty
                  ? Image.asset(
                      item.productImage,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image, color: Colors.grey);
                      },
                    )
                  : const Icon(Icons.image, color: Colors.grey),
            ),
            const SizedBox(width: 12),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.productName, style: AppTheme.heading3),
                  const SizedBox(height: 4),
                  if (item.selectedOptions.isNotEmpty)
                    Text(
                      item.selectedOptions.entries
                          .map((e) => '${e.key}: ${e.value}')
                          .join(', '),
                      style: AppTheme.bodySmall,
                    ),
                  const SizedBox(height: 4),
                  Text(
                    '£${item.unitPrice.toStringAsFixed(2)} each',
                    style: AppTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  // Quantity Controls
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: item.quantity > 1
                            ? () => cartProvider.decrementQuantity(item.id)
                            : null,
                        iconSize: 20,
                      ),
                      Text(' ${item.quantity} ', style: AppTheme.bodyLarge),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () => cartProvider.incrementQuantity(item.id),
                        iconSize: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Price and Remove
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => cartProvider.removeItem(item.id),
                ),
                const SizedBox(height: 8),
                Text(
                  '£${item.totalPrice.toStringAsFixed(2)}',
                  style: AppTheme.priceText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
