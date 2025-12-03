// lib/pages/collection_view_page.dart
import 'package:flutter/material.dart';

import '../widgets/app_header.dart';
import '../widgets/footer.dart';
import '../widgets/product_card.dart';
import '../data/dummy_products.dart';
import '../data/dummy_collections.dart';
import '../models/collection.dart';

class CollectionViewPage extends StatefulWidget {
  const CollectionViewPage({super.key});

  @override
  State<CollectionViewPage> createState() => _CollectionViewPageState();
}

class _CollectionViewPageState extends State<CollectionViewPage> {
  // UI state for filters/sorting/pagination
  String selectedSort = 'popular';
  String selectedSize = 'all';
  String selectedColour = 'all';
  String selectedFit = 'all';

    // New underscored state variables (for dropdown `value:`)
  String _selectedSort = 'popular';
  String _selectedSize = 'all';
  String _selectedColour = 'all';
  String _selectedFit = 'all';
  // Pagination state
  int _currentPage = 1;
  int itemsPerPage = 4;

  double _parsePrice(String price) {
    final cleaned = price.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  void _placeholder() {}
  @override
  Widget build(BuildContext context) {
    // 👇 read slug passed from /collections
    final slug = ModalRoute.of(context)?.settings.arguments as String?;
    // fallback if null
    final String effectiveSlug = slug ?? 'hoodies';

    // find matching collection metadata
    final Collection? selectedCollection = dummyCollections
        .where((c) => c.slug == effectiveSlug)
        .cast<Collection?>()
        .firstWhere(
          (c) => c != null,
          orElse: () => null,
        );

    final title = selectedCollection?.title ?? 'Collection';
    final description = selectedCollection?.description ??
        'Products in this collection.';

    // filter products by collectionSlug
    var collectionProducts = dummyProducts
        .where((p) => p.collectionSlug == effectiveSlug)
        .toList();

    // apply simple sorting based on the selected sort state
    if (_selectedSort == 'price_low_high') {
      collectionProducts.sort((a, b) =>
          double.parse(a.price.replaceAll(RegExp(r'[^0-9\.]'), ''))
              .compareTo(double.parse(
                  b.price.replaceAll(RegExp(r'[^0-9\.]'), ''))));
    } else if (_selectedSort == 'price_high_low') {
      collectionProducts.sort((a, b) =>
          double.parse(b.price.replaceAll(RegExp(r'[^0-9\.]'), ''))
              .compareTo(double.parse(
                  a.price.replaceAll(RegExp(r'[^0-9\.]'), ''))));
    } else if (_selectedSort == 'az') {
      collectionProducts.sort((a, b) => a.title.compareTo(b.title));
    } else if (_selectedSort == 'za') {
      collectionProducts.sort((a, b) => b.title.compareTo(a.title));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppHeader(
              onLogoTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
              onSearchTap: _placeholder,
              onAccountTap: () {
                Navigator.pushNamed(context, '/login');
              },
              onCartTap: () {
                Navigator.pushNamed(context, '/cart');
              },
              onMenuTap: _placeholder,
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- Pagination ---
                  final int startIndex = (_currentPage - 1) * itemsPerPage;
                  final int endIndex = (startIndex + itemsPerPage) > collectionProducts.length
                      ? collectionProducts.length
                      : startIndex + itemsPerPage;
                  final paginatedProducts = collectionProducts.sublist(
                    startIndex.clamp(0, collectionProducts.length).toInt(),
                    endIndex.clamp(0, collectionProducts.length).toInt(),
                  );

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _currentPage > 1
                            ? () => setState(() => _currentPage--)
                            : null,
                        child: const Text('Previous'),
                      ),
                      Text('Page $_currentPage of ${ (collectionProducts.length / itemsPerPage).ceil() }'),
                      ElevatedButton(
                        onPressed: _currentPage * itemsPerPage < collectionProducts.length
                            ? () => setState(() => _currentPage++)
                            : null,
                        child: const Text('Next'),
                      ),
                    ],
                  ),

                  // Sorting already applied above using `_selectedSort`.

                  // (keep your filters the same)
                  // Fake filters (UI only)
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedSort,
                          decoration: const InputDecoration(
                            labelText: 'Sort by',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'popular',
                              child: Text('Most popular'),
                            ),
                            DropdownMenuItem(
                              value: 'price_low_high',
                              child: Text('Price: Low to High'),
                            ),
                            DropdownMenuItem(
                              value: 'price_high_low',
                              child: Text('Price: High to Low'),
                            ),
                            DropdownMenuItem(value: 'az', child: Text('A → Z')),
                            DropdownMenuItem(value: 'za', child: Text('Z → A')),
                          ],
                          onChanged: (v) => setState(() {
                            _selectedSort = v ?? 'popular';
                          }),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedSize,
                          decoration: const InputDecoration(
                            labelText: 'Size',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'all',
                              child: Text('All sizes'),
                            ),
                            DropdownMenuItem(
                              value: 's',
                              child: Text('S'),
                            ),
                            DropdownMenuItem(
                              value: 'm',
                              child: Text('M'),
                            ),
                            DropdownMenuItem(
                              value: 'l',
                              child: Text('L'),
                            ),
                            DropdownMenuItem(
                              value: 'xl',
                              child: Text('XL'),
                            ),
                          ],
                          onChanged: (_) {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedColour,
                          decoration: const InputDecoration(
                            labelText: 'Colour',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'all',
                              child: Text('All colours'),
                            ),
                            DropdownMenuItem(
                              value: 'black',
                              child: Text('Black'),
                            ),
                            DropdownMenuItem(
                              value: 'grey',
                              child: Text('Grey'),
                            ),
                            DropdownMenuItem(
                              value: 'navy',
                              child: Text('Navy'),
                            ),
                          ],
                          onChanged: (_) {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedFit,
                          decoration: const InputDecoration(
                            labelText: 'Fit',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'all',
                              child: Text('All fits'),
                            ),
                            DropdownMenuItem(
                              value: 'regular',
                              child: Text('Regular'),
                            ),
                            DropdownMenuItem(
                              value: 'oversized',
                              child: Text('Oversized'),
                            ),
                          ],
                          onChanged: (_) {},
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Grid of products in this collection
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 3 / 4,
                    children: paginatedProducts.isEmpty
                        ? const [
                            Center(
                              child: Text('No products in this collection yet.'),
                            ),
                          ]
                        : paginatedProducts.map((product) {
                            return ProductCard(
                              title: product.title,
                              price: product.price,
                              imageUrl: 'https://via.placeholder.com/400x400?text=Product',
                            );
                          }).toList(),
                  ),
                ],
              ),
            ),

            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

class _CollectionProductCard extends StatelessWidget {
  final String title;
  final String price;

  const _CollectionProductCard({
    super.key,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                'Image',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          price,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
