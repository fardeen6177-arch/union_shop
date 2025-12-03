import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/utils/constants.dart';

void main() {
  group('Price Calculation Tests', () {
    test('Tax rate is 10%', () {
      expect(AppConstants.taxRate, 0.10);
    });

    test('Calculate tax correctly', () {
      double subtotal = 100.0;
      double tax = subtotal * AppConstants.taxRate;
      expect(tax, 10.0);
    });

    test('Calculate total with tax', () {
      double subtotal = 50.0;
      double tax = subtotal * AppConstants.taxRate;
      double total = subtotal + tax;
      expect(total, 55.0);
    });

    test('Calculate tax for zero subtotal', () {
      double subtotal = 0.0;
      double tax = subtotal * AppConstants.taxRate;
      expect(tax, 0.0);
    });

    test('Calculate tax for decimal subtotal', () {
      double subtotal = 99.99;
      double tax = subtotal * AppConstants.taxRate;
      expect(tax, closeTo(9.999, 0.01));
    });

    test('Multiple items subtotal calculation', () {
      // Item 1: 2 x £25.00 = £50.00
      // Item 2: 3 x £15.00 = £45.00
      // Subtotal = £95.00
      double item1Total = 2 * 25.00;
      double item2Total = 3 * 15.00;
      double subtotal = item1Total + item2Total;
      
      expect(subtotal, 95.0);
      
      double tax = subtotal * AppConstants.taxRate;
      expect(tax, 9.5);
      
      double total = subtotal + tax;
      expect(total, 104.5);
    });

    test('Sale price calculation', () {
      double originalPrice = 100.0;
      double salePrice = 75.0;
      double discount = originalPrice - salePrice;
      double discountPercentage = (discount / originalPrice) * 100;
      
      expect(discount, 25.0);
      expect(discountPercentage, 25.0); // 25% off
    });

    test('Max cart quantity limit', () {
      expect(AppConstants.maxCartQuantity, 10);
    });
  });
}
