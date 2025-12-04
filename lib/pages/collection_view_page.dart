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
  String _selectedSort = 'popular';
  final String _selectedSize = 'all';
  final String _selectedColour = 'all';
  final String _selectedFit = 'all';

  int _currentPage = 1;
  int itemsPerPage = 3;

  double _parsePrice(String price) {
    final cleaned = price.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  void _placeholder() {}

  @override
  Widget build(BuildContext context) {
    // slug passed from /collections
    final slug = ModalRoute.of(context)?.settings.arguments as String?;
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
    final description =
        selectedCollection?.description ?? 'Products in this collection.';

    // filter products by collectionSlug
    var collectionProducts = dummyProducts
        .where((p) => p.collectionSlug == effectiveSlug)
        .toList();

    // apply sorting
    if (_selectedSort == 'price_low_high') {
      collectionProducts
          .sort((a, b) => _parsePrice(a.price).compareTo(_parsePrice(b.price)));
    } else if (_selectedSort == 'price_high_low') {
      collectionProducts
          .sort((a, b) => _parsePrice(b.price).compareTo(_parsePrice(a.price)));
    } else if (_selectedSort == 'az') {
      collectionProducts.sort((a, b) => a.title.compareTo(b.title));
    } else if (_selectedSort == 'za') {
      collectionProducts.sort((a, b) => b.title.compareTo(a.title));
    }

    // ----- pagination logic (MOVED OUT of children[]) -----
    List paginatedProducts;
    if (collectionProducts.isEmpty) {
      paginatedProducts = [];
    } else {
      final totalItems = collectionProducts.length;
      final totalPages = (totalItems / itemsPerPage).ceil();
      final safePage = _currentPage.clamp(1, totalPages);

      final startIndex = (safePage - 1) * itemsPerPage;
      var endIndex = startIndex + itemsPerPage;
      if (endIndex > totalItems) endIndex = totalItems;

      paginatedProducts = collectionProducts.sublist(startIndex, endIndex);
    }
    // --------------------------------------------

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
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/collections');
                  },
                  child: const Text('Back to all collections'),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + description
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

                  // --- Pagination controls ---
                  if (collectionProducts.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: _currentPage > 1
                              ? () => setState(() {
                                    _currentPage--;
                                  })
                              : null,
                          child: const Text('Previous'),
                        ),
                        Text(
                          'Page $_currentPage of ${(collectionProducts.length / itemsPerPage).ceil()}',
                        ),
                        ElevatedButton(
                          onPressed:
                              _currentPage * itemsPerPage < collectionProducts.length
                                  ? () => setState(() {
                                        _currentPage++;
                                      })
                                  : null,
                          child: const Text('Next'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],

                  // --- Filters ---
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
                            DropdownMenuItem(
                              value: 'az',
                              child: Text('A → Z'),
                            ),
                            DropdownMenuItem(
                              value: 'za',
                              child: Text('Z → A'),
                            ),
                          ],
                          onChanged: (v) {
                            setState(() {
                              _selectedSort = v ?? 'popular';
                              _currentPage = 1; // reset page on sort change
                            });
                          },
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
                          onChanged: (_) {
                            // you can add real filter logic later
                          },
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
                          onChanged: (_) {
                            // later: apply colour filters
                          },
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
                          onChanged: (_) {
                            // later: apply fit filters
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // List of products in this collection (1 per row)
                  if (paginatedProducts.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text('No products in this collection yet.'),
                      ),
                    )
                  else
                    ...paginatedProducts.map((product) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: SizedBox(
                          height: 400,
                          child: ProductCard(
                            id: product.id,
                            collectionSlug: product.collectionSlug,
                            title: product.title,
                            price: product.price,
                            imageUrl: product.imageUrl ?? 'https://via.placeholder.com/400x400?text=Product',
                          ),
                        ),
                      );
                    }).toList(),
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

// (removed unused helper widget)
