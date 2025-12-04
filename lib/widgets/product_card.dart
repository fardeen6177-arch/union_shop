// lib/widgets/product_card.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/product.dart';
import '../config/theme.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/product/${product.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.grey[200],
                child: product.images.isNotEmpty
                    ? Image.asset(
                        product.images[0],
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.image, size: 48, color: Colors.grey),
                          );
                        },
                      )
                    : const Center(
                        child: Icon(Icons.image, size: 48, color: Colors.grey),
                      ),
              ),
            ),
            // Product Info
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTheme.heading3.copyWith(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (product.isOnSale) ...[
                    Row(
                      children: [
                        Text(
                          '£${product.salePrice!.toStringAsFixed(2)}',
                          style: AppTheme.salePriceText.copyWith(fontSize: 16),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '£${product.price.toStringAsFixed(2)}',
                          style: AppTheme.originalPriceText.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ] else ...[
                    Text(
                      '£${product.price.toStringAsFixed(2)}',
                      style: AppTheme.priceText.copyWith(fontSize: 16),
                    ),
                  ],
                  if (!product.isInStock)
                    Text(
                      'Out of Stock',
                      style: TextStyle(color: AppTheme.errorColor, fontSize: 12),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
