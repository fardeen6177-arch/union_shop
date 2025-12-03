// lib/pages/cart_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/cart_item_widget.dart';
import '../config/theme.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final authProvider = context.watch<AuthProvider>();

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
                  const SizedBox(height: 16),
                  Text('Shopping Cart', style: AppTheme.heading1),
                  const SizedBox(height: 24),
                  
                  if (cartProvider.isEmpty) ...[
                    Center(
                      child: Column(
                        children: [
                          const Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey),
                          const SizedBox(height: 16),
                          Text('Your cart is empty', style: AppTheme.bodyLarge),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => context.go('/'),
                            child: const Text('Continue Shopping'),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    // Cart Items
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartProvider.items.length,
                      itemBuilder: (context, index) {
                        return CartItemWidget(item: cartProvider.items[index]);
                      },
                    ),
                    
                    const SizedBox(height: 24),
                    const Divider(),
                    
                    // Price Summary
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal:', style: AppTheme.bodyLarge),
                            Text('£${cartProvider.subtotal.toStringAsFixed(2)}', style: AppTheme.bodyLarge),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tax (10%):', style: AppTheme.bodyLarge),
                            Text('£${cartProvider.tax.toStringAsFixed(2)}', style: AppTheme.bodyLarge),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total:', style: AppTheme.heading2),
                            Text('£${cartProvider.total.toStringAsFixed(2)}', style: AppTheme.priceText),
                          ],
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Checkout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (authProvider.isLoggedIn) {
                            context.push('/checkout');
                          } else {
                            context.push('/login');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(authProvider.isLoggedIn ? 'Proceed to Checkout' : 'Login to Checkout'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
