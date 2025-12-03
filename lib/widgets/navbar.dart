// lib/widgets/navbar.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import '../config/theme.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final auth = context.watch<AuthProvider>();

    return AppBar(
      title: InkWell(
        onTap: () => context.go('/'),
        child: const Text('Union Shop', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      actions: [
        // Search Icon
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => context.push('/search'),
          tooltip: 'Search',
        ),
        // Cart Icon with Badge
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => context.push('/cart'),
              tooltip: 'Cart',
            ),
            if (cart.itemCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppTheme.errorColor,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '${cart.itemCount}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        // Account Icon
        IconButton(
          icon: Icon(auth.isLoggedIn ? Icons.account_circle : Icons.account_circle_outlined),
          onPressed: () {
            if (auth.isLoggedIn) {
              context.push('/account');
            } else {
              context.push('/login');
            }
          },
          tooltip: auth.isLoggedIn ? 'Account' : 'Login',
        ),
      ],
    );
  }
}
