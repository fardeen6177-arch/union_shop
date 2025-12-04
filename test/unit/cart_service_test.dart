 // Unit tests for CartService
 import 'package:flutter_test/flutter_test.dart';
 import 'package:shared_preferences/shared_preferences.dart';
 import 'package:flutter_application_1/services/cart_service.dart';
 import 'package:flutter_application_1/models/cart_item.dart';
 // ...existing code...

void main() {
  group('CartService Tests', () {
    late CartService cartService;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      cartService = CartService();
    });

    test('Cart starts empty', () {
      expect(cartService.isEmpty, true);
      expect(cartService.itemCount, 0);
      expect(cartService.getSubtotal(), 0.0);
    });

    test('Add item to cart increases count', () async {
      final item = CartItem(
        id: 'test1',
        productId: 'prod1',
        quantity: 2,
        selectedOptions: {},
        unitPrice: 25.0,
        productName: 'Test Product',
        productImage: '',
      );

      await cartService.addToCart(item);

      expect(cartService.items.length, 1);
      expect(cartService.itemCount, 2);
    });

    test('Subtotal calculates correctly', () async {
      final item1 = CartItem(
        id: 'test1',
        productId: 'prod1',
        quantity: 2,
        unitPrice: 25.0,
        selectedOptions: {},
        productName: 'Test Product 1',
        productImage: '',
      );

      final item2 = CartItem(
        id: 'test2',
        productId: 'prod2',
        quantity: 1,
        unitPrice: 30.0,
        selectedOptions: {},
        productName: 'Test Product 2',
        productImage: '',
      );

      await cartService.addToCart(item1);
      await cartService.addToCart(item2);

      // (2 * 25.0) + (1 * 30.0) = 80.0
      expect(cartService.getSubtotal(), 80.0);
    });

    test('Tax calculates correctly at 10%', () async {
      final item = CartItem(
        id: 'test1',
        productId: 'prod1',
        quantity: 1,
        unitPrice: 100.0,
        selectedOptions: {},
        productName: 'Test Product',
        productImage: '',
      );

      await cartService.addToCart(item);

      expect(cartService.getTax(), 10.0); // 10% of 100
      expect(cartService.getTotal(), 110.0); // 100 + 10
    });

    test('Remove item from cart', () async {
      final item = CartItem(
        id: 'test1',
        productId: 'prod1',
        quantity: 1,
        unitPrice: 25.0,
        selectedOptions: {},
        productName: 'Test Product',
        productImage: '',
      );

      await cartService.addToCart(item);
      expect(cartService.items.length, 1);

      await cartService.removeFromCart('test1');
      expect(cartService.items.length, 0);
      expect(cartService.isEmpty, true);
    });

    test('Update item quantity', () async {
      final item = CartItem(
        id: 'test1',
        productId: 'prod1',
        quantity: 1,
        unitPrice: 25.0,
        selectedOptions: {},
        productName: 'Test Product',
        productImage: '',
      );

      await cartService.addToCart(item);
      await cartService.updateQuantity('test1', 5);

      expect(cartService.items[0].quantity, 5);
      expect(cartService.itemCount, 5);
    });

    test('Clear cart removes all items', () async {
      final item1 = CartItem(
        id: 'test1',
        productId: 'prod1',
        quantity: 2,
        unitPrice: 25.0,
        selectedOptions: {},
        productName: 'Test Product 1',
        productImage: '',
      );

      final item2 = CartItem(
        id: 'test2',
        productId: 'prod2',
        quantity: 1,
        unitPrice: 30.0,
        selectedOptions: {},
        productName: 'Test Product 2',
        productImage: '',
      );

      await cartService.addToCart(item1);
      await cartService.addToCart(item2);
      expect(cartService.items.length, 2);

      await cartService.clearCart();
      expect(cartService.isEmpty, true);
      expect(cartService.getSubtotal(), 0.0);
    });
  });
}
