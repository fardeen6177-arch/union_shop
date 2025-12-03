// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/product_provider.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/product_card.dart';
import '../widgets/collection_card.dart';
import '../config/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    return Scaffold(
      appBar: const Navbar(),
      body: productProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Hero Section
                  _buildHeroSection(context),
                  const SizedBox(height: 32),
                  
                  // Featured Collections
                  _buildFeaturedCollections(context, productProvider),
                  const SizedBox(height: 32),
                  
                  // Sale Products
                  _buildSaleSection(context, productProvider),
                  const SizedBox(height: 32),
                  
                  const Footer(),
                ],
              ),
            ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryColor, AppTheme.accentColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Union Shop',
              style: AppTheme.heading1.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Discover amazing products at great prices',
              style: AppTheme.bodyLarge.copyWith(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.push('/collections'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppTheme.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Shop Now'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedCollections(BuildContext context, ProductProvider provider) {
    final collections = provider.collections.take(4).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Featured Collections', style: AppTheme.heading2),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: collections.length,
            itemBuilder: (context, index) {
              return CollectionCard(collection: collections[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSaleSection(BuildContext context, ProductProvider provider) {
    final saleProducts = provider.getSaleProducts().take(4).toList();

    if (saleProducts.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('On Sale', style: AppTheme.heading2),
              TextButton(
                onPressed: () => context.push('/collection/col_3'),
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: saleProducts.length,
            itemBuilder: (context, index) {
              return ProductCard(product: saleProducts[index]);
            },
          ),
        ],
      ),
    );
  }
}
