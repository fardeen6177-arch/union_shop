// lib/main.dart
import 'package:flutter/material.dart';
import 'views/app_styles.dart';
import 'repositories/order_repository.dart';
import 'repositories/pricing_repository.dart';
import 'view_model/order_view_model.dart';
import 'widgets/order_item_display.dart';
import 'widgets/styled_button.dart';

void main() {
  runApp(const SandwichApp());
}

class SandwichApp extends StatelessWidget {
  const SandwichApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandwich Shop App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        useMaterial3: true,
      ),
      home: const OrderScreen(maxQuantity: 10),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OrderScreen extends StatefulWidget {
  final int maxQuantity;
  const OrderScreen({super.key, required this.maxQuantity});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

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

class _OrderScreenState extends State<OrderScreen> {
  late final OrderRepository _orderRepository;
  late final PricingRepository _pricingRepository;
  final OrderViewModel _viewModel = OrderViewModel();

  bool _isFootlong = true;
  BreadType _selectedBreadType = BreadType.white;
  bool _isToasted = false;

  @override
  void initState() {
    super.initState();
    _orderRepository = OrderRepository(maxQuantity: widget.maxQuantity);
    _pricingRepository = PricingRepository();
  }

  VoidCallback? _getIncreaseCallback() {
    if (_orderRepository.canIncrement) {
      return () => setState(_orderRepository.increment);
    }
    return null;
  }

  VoidCallback? _getDecreaseCallback() {
    if (_orderRepository.canDecrement) {
      return () => setState(_orderRepository.decrement);
    }
    return null;
  }

  void _onSandwichTypeChanged(bool value) {
    setState(() => _isFootlong = value);
  }

  void _onBreadTypeSelected(BreadType? value) {
    if (value != null) {
      setState(() => _selectedBreadType = value);
    }
  }

  Future<void> _saveOrder() async {
    await _viewModel.saveOrderToFile(
      quantity: _orderRepository.quantity,
      isFootlong: _isFootlong,
      bread: breadName(_selectedBreadType),
      isToasted: _isToasted,
    );

    final p = await _viewModel.fileService.filePath();
    // print path for debugging (student instruction suggests this)
    // ignore: avoid_print
    print('Order saved to: $p');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order saved to file')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final sandwichTypeLabel = _isFootlong ? 'footlong' : 'six-inch';
    final sizeEnum =
        _isFootlong ? SandwichSize.footlong : SandwichSize.sixInch; // from pricing

    final total = _pricingRepository.totalPrice(
      quantity: _orderRepository.quantity,
      size: sizeEnum,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandwich Counter', style: heading1),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
            key: const Key('app_logo'), // used by widget test
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              OrderItemDisplay(
                quantity: _orderRepository.quantity,
                sizeLabel: sandwichTypeLabel,
                bread: _selectedBreadType,
                isToasted: _isToasted,
              ),

              const SizedBox(height: 16),

              // sandwich type switch (uniquely keyed)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('six-inch', style: normalText),
                  Switch(
                    key: const Key('size_switch'),
                    value: _isFootlong,
                    onChanged: _onSandwichTypeChanged,
                  ),
                  const Text('footlong', style: normalText),
                ],
              ),

              const SizedBox(height: 8),

              // toasted switch (also uniquely keyed)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('untoasted', style: normalText),
                  Switch(
                    key: const Key('toasted_switch'),
                    value: _isToasted,
                    onChanged: (value) => setState(() => _isToasted = value),
                  ),
                  const Text('toasted', style: normalText),
                ],
              ),

              const SizedBox(height: 12),

              // bread dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Bread: ', style: normalText),
                  const SizedBox(width: 8),
                  DropdownButton<BreadType>(
                    value: _selectedBreadType,
                    onChanged: _onBreadTypeSelected,
                    items: BreadType.values.map((b) {
                      return DropdownMenuItem(
                        value: b,
                        child: Text(breadName(b)),
                      );
                    }).toList(),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Add/Remove buttons (StyledButton uses onPressed null => disabled)
              Row(
                children: [
                  StyledButton(
                    label: 'Remove',
                    icon: Icons.remove,
                    onPressed: _getDecreaseCallback(),
                    enabled: _orderRepository.canDecrement,
                  ),
                  const Spacer(),
                  StyledButton(
                    label: 'Add',
                    icon: Icons.add,
                    onPressed: _getIncreaseCallback(),
                    enabled: _orderRepository.canIncrement,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Text(
                'Total: £${total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              // Save order button
              StyledButton(
                label: 'Save Order',
                icon: Icons.save,
                onPressed: () => _saveOrder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
