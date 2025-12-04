// lib/pages/product_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../config/theme.dart';

class ProductPage extends StatefulWidget {
  final String productId;

  const ProductPage({super.key, required this.productId});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _quantity = 1;
  final Map<String, String> _selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final product = productProvider.getProductById(widget.productId);

    if (product == null) {
      return Scaffold(
        appBar: const Navbar(),
        body: const Center(child: Text('Product not found')),
      );
    }

    // Initialize selected options
    if (_selectedOptions.isEmpty) {
      product.options.forEach((key, values) {
        if (values.isNotEmpty) {
          _selectedOptions[key] = values[0];
        }
      });
    }

    return Scaffold(
      appBar: const Navbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Images
                  Container(
                    height: 400,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: product.images.isNotEmpty
                        ? Image.asset(
                            product.images[0],
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(Icons.image, size: 100, color: Colors.grey),
                              );
                            },
                          )
                        : const Center(
                            child: Icon(Icons.image, size: 100, color: Colors.grey),
                          ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Product Name
                  Text(product.name, style: AppTheme.heading1),
                  const SizedBox(height: 8),
                  
                  // Price
                  if (product.isOnSale) ...[
                    Row(
                      children: [
                        Text(
                          '�${product.salePrice!.toStringAsFixed(2)}',
                          style: AppTheme.salePriceText,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '£${product.price.toStringAsFixed(2)}',
                          style: AppTheme.originalPriceText,
                        ),
                      ],
                    ),
                  ] else ...[
                    Text(
                      '£${product.price.toStringAsFixed(2)}',
                      style: AppTheme.priceText,
                    ),
                  ],
                  
                  const SizedBox(height: 16),
                  
                  // Stock Status
                  Text(
                    product.isInStock ? 'In Stock (${product.stock})' : 'Out of Stock',
                    style: TextStyle(
                      color: product.isInStock ? AppTheme.successColor : AppTheme.errorColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Description
                  Text('Description', style: AppTheme.heading3),
                  const SizedBox(height: 8),
                  Text(product.description, style: AppTheme.bodyLarge),
                  
                  const SizedBox(height: 24),
                  
                  // Options
                  ...product.options.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.key, style: AppTheme.heading3),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: entry.value.map((option) {
                            final isSelected = _selectedOptions[entry.key] == option;
                            return ChoiceChip(
                              label: Text(option),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedOptions[entry.key] = option;
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }),
                  
                  // Quantity Selector
                  Row(
                    children: [
                      Text('Quantity:', style: AppTheme.heading3),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: _quantity > 1
                            ? () => setState(() => _quantity--)
                            : null,
                      ),
                      Text('$_quantity', style: AppTheme.bodyLarge),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () => setState(() => _quantity++),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Add to Cart'),
                      onPressed: product.isInStock
                          ? () async {
                              try {
                                await context.read<CartProvider>().addToCart(
                                      product: product,
                                      selectedOptions: _selectedOptions,
                                      quantity: _quantity,
                                    );
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Added to cart!'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
