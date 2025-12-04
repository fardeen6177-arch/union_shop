// lib/pages/personalise_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../config/theme.dart';

class PersonalisePage extends StatefulWidget {
  const PersonalisePage({super.key});

  @override
  State<PersonalisePage> createState() => _PersonalisePageState();
}

class _PersonalisePageState extends State<PersonalisePage> {
  final TextEditingController _textController = TextEditingController();
  String _selectedFont = 'Arial';
  Color _selectedColor = Colors.black;
  
  final List<String> _fonts = ['Arial', 'Times New Roman', 'Courier', 'Georgia'];
  final List<Color> _colors = [
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
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
                  Text('Print Shack - Personalise Your Product', style: AppTheme.heading1),
                  const SizedBox(height: 24),
                  
                  // Text Input
                  TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your custom text',
                      hintText: 'Type something...',
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Font Selection
                  Text('Select Font', style: AppTheme.heading3),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _fonts.map((font) {
                      return ChoiceChip(
                        label: Text(font),
                        selected: _selectedFont == font,
                        onSelected: (_) => setState(() => _selectedFont = font),
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Color Selection
                  Text('Select Color', style: AppTheme.heading3),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    children: _colors.map((color) {
                      return InkWell(
                        onTap: () => setState(() => _selectedColor = color),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _selectedColor == color ? Colors.black : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Live Preview
                  Text('Preview', style: AppTheme.heading3),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        _textController.text.isEmpty ? 'Your text here' : _textController.text,
                        style: TextStyle(
                          fontFamily: _selectedFont,
                          color: _selectedColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Add to Cart
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Add Custom Product to Cart (£34.99)'),
                      onPressed: _textController.text.isEmpty
                          ? null
                          : () async {
                              try {
                                await context.read<CartProvider>().addToCart(
                                  product: _createDummyProduct(),
                                  selectedOptions: {
                                    'text': _textController.text,
                                    'font': _selectedFont,
                                    'color': _selectedColor.toString(),
                                  },
                                );
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Custom product added to cart!')),
                                  );
                                  _textController.clear();
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
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
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

  // Helper method to create a dummy product for custom items
  dynamic _createDummyProduct() {
    return null; // This will be handled by the cart provider
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
