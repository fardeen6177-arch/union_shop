import 'package:flutter/material.dart';

enum BreadType { white, wholemeal, rye, sourdough }

String breadName(BreadType b) {
  switch (b) {
    case BreadType.white:
      return 'White';
    case BreadType.wholemeal:
      return 'Wholemeal';
    case BreadType.rye:
      return 'Rye';
    case BreadType.sourdough:
      return 'Sourdough';
  }
}

class OrderItemDisplay extends StatelessWidget {
  final int quantity;
  final String sizeLabel;
  final BreadType bread;

  const OrderItemDisplay({
    super.key,
    required this.quantity,
    required this.sizeLabel,
    required this.bread,
  });

  String _emojiString(int qty) {
    return List.filled(qty, '🥪').join();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$quantity x $sizeLabel ${quantity == 1 ? "sandwich" : "sandwiches"}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Bread: ${breadName(bread)}',
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 6),
        Text(
          _emojiString(quantity),
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
