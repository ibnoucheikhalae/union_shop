// lib/pages/collection_view_page.dart
import 'package:flutter/material.dart';

import '../widgets/app_header.dart';
import '../widgets/footer.dart';
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

  // New underscored state variables (wired to dropdown `value:`)
  String _selectedSort = 'popular';
  String _selectedSize = 'all';
  String _selectedColour = 'all';
  String _selectedFit = 'all';
  int currentPage = 0;
  static const int pageSize = 6;

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

    // apply simple sorting based on selectedSort state
    if (selectedSort == 'price_low_high') {
      collectionProducts.sort((a, b) =>
          double.parse(a.price.replaceAll(RegExp(r'[^0-9\.]'), ''))
              .compareTo(double.parse(
                  b.price.replaceAll(RegExp(r'[^0-9\.]'), ''))));
    } else if (selectedSort == 'price_high_low') {
      collectionProducts.sort((a, b) =>
          double.parse(b.price.replaceAll(RegExp(r'[^0-9\.]'), ''))
              .compareTo(double.parse(
                  a.price.replaceAll(RegExp(r'[^0-9\.]'), ''))));
    } else if (selectedSort == 'az') {
      collectionProducts.sort((a, b) => a.title.compareTo(b.title));
    } else if (selectedSort == 'za') {
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

                  // --- Sorting: apply only, do not filter ---
                  // Sort by price or leave unchanged for 'popular'
                  if (_selectedSort == 'price_low_high') {
                    collectionProducts.sort((a, b) {
                      final pa = double.tryParse(
                              a.price.replaceAll(RegExp(r'[^0-9\.]'), '')) ??
                          0.0;
                      final pb = double.tryParse(
                              b.price.replaceAll(RegExp(r'[^0-9\.]'), '')) ??
                          0.0;
                      return pa.compareTo(pb);
                    });
                  } else if (_selectedSort == 'price_high_low') {
                    collectionProducts.sort((a, b) {
                      final pa = double.tryParse(
                              a.price.replaceAll(RegExp(r'[^0-9\.]'), '')) ??
                          0.0;
                      final pb = double.tryParse(
                              b.price.replaceAll(RegExp(r'[^0-9\.]'), '')) ??
                          0.0;
                      return pb.compareTo(pa);
                    });
                  }

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
                            selectedSort = v ?? 'popular';
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
                    children: collectionProducts.isEmpty
                        ? const [
                            Center(
                              child: Text('No products in this collection yet.'),
                            ),
                          ]
                        : collectionProducts
                            .map(
                              (product) => _CollectionProductCard(
                                title: product.title,
                                price: product.price,
                              ),
                            )
                            .toList(),
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
