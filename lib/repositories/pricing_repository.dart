// lib/repositories/pricing_repository.dart
import 'order_repository.dart';

enum SandwichSize { sixInch, footlong }

class PricingRepository {
  final double sixInchPrice;
  final double footlongPrice;

  PricingRepository({
    this.sixInchPrice = 7.0,
    this.footlongPrice = 11.0,
  });

  double priceForSize(SandwichSize size) {
    switch (size) {
      case SandwichSize.sixInch:
        return sixInchPrice;
      case SandwichSize.footlong:
        return footlongPrice;
    }
  }

  /// Calculate total price given quantity and size.
  double totalPrice({required int quantity, required SandwichSize size}) {
    final unit = priceForSize(size);
    return unit * quantity;
  }
}
