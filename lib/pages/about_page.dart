// lib/pages/about_page.dart
import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../config/theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
                  Text('About Union Shop', style: AppTheme.heading1),
                  const SizedBox(height: 24),
                  
                  Text(
                    'Welcome to Union Shop, your premier destination for quality clothing and accessories.',
                    style: AppTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  
                  Text('Our Mission', style: AppTheme.heading2),
                  const SizedBox(height: 8),
                  Text(
                    'We strive to provide our customers with the best quality products at affordable prices. Our mission is to make fashion accessible to everyone.',
                    style: AppTheme.bodyLarge,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  Text('What We Offer', style: AppTheme.heading2),
                  const SizedBox(height: 8),
                  Text(
                    '• High-quality t-shirts and apparel\n'
                    '• Comfortable hoodies and sweatshirts\n'
                    '• Stylish accessories\n'
                    '• Custom personalization options\n'
                    '• Regular sales and promotions',
                    style: AppTheme.bodyLarge,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  Text('Contact Us', style: AppTheme.heading2),
                  const SizedBox(height: 8),
                  Text(
                    'Email: support@unionshop.com\n'
                    'Phone: +44 123 456 7890\n'
                    'Address: 123 Shop Street, London, UK',
                    style: AppTheme.bodyLarge,
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
}
