// lib/pages/search_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/search_provider.dart';
import '../services/search_service.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/product_card.dart';
import '../config/theme.dart';

class SearchPage extends StatefulWidget {
  final String initialQuery;

  const SearchPage({super.key, this.initialQuery = ''});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.initialQuery;
    if (widget.initialQuery.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<SearchProvider>().setSearchQuery(widget.initialQuery);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final searchProvider = context.watch<SearchProvider>();
    
    final filteredProducts = searchProvider.applyFilters(productProvider.products);

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
                  Text('Search Products', style: AppTheme.heading1),
                  const SizedBox(height: 16),
                  
                  // Search Bar
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                searchProvider.setSearchQuery('');
                              },
                            )
                          : null,
                    ),
                    onChanged: (value) => searchProvider.setSearchQuery(value),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Sort Dropdown
                  Row(
                    children: [
                      const Text('Sort by:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 12),
                      DropdownButton<SortOption>(
                        value: searchProvider.sortOption,
                        onChanged: (value) {
                          if (value != null) {
                            searchProvider.setSortOption(value);
                          }
                        },
                        items: const [
                          DropdownMenuItem(value: SortOption.nameAsc, child: Text('Name (A-Z)')),
                          DropdownMenuItem(value: SortOption.nameDesc, child: Text('Name (Z-A)')),
                          DropdownMenuItem(value: SortOption.priceAsc, child: Text('Price (Low-High)')),
                          DropdownMenuItem(value: SortOption.priceDesc, child: Text('Price (High-Low)')),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // In Stock Filter
                  CheckboxListTile(
                    title: const Text('In Stock Only'),
                    value: searchProvider.onlyInStock,
                    onChanged: (_) => searchProvider.toggleInStock(),
                    dense: true,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Results Count
                  Text(
                    '${filteredProducts.length} products found',
                    style: AppTheme.heading3,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Results Grid
                  filteredProducts.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(48.0),
                            child: Text('No products found'),
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            return ProductCard(product: filteredProducts[index]);
                          },
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
