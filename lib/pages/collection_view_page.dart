import 'package:flutter/material.dart';
import '../widgets/app_header.dart';

class CollectionViewPage extends StatelessWidget {
  const CollectionViewPage({super.key});

  void _placeholder() {}

  @override
  Widget build(BuildContext context) {
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
              onAccountTap: _placeholder,
              onCartTap: _placeholder,
              onMenuTap: _placeholder,
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hoodies & Sweatshirts',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Warm and comfy uni hoodies for everyday campus life.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Fake filters (UI only)
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
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
                          ],
                          onChanged: (_) {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
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

                  // Grid of dummy products
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 3 / 4,
                    children: const [
                      _CollectionProductCard(
                        title: 'Classic Uni Hoodie',
                        price: '£35.00',
                      ),
                      _CollectionProductCard(
                        title: 'Oversized Campus Hoodie',
                        price: '£38.00',
                      ),
                      _CollectionProductCard(
                        title: 'Zip-Up Sports Hoodie',
                        price: '£40.00',
                      ),
                      _CollectionProductCard(
                        title: 'Heritage Logo Sweatshirt',
                        price: '£32.00',
                      ),
                      _CollectionProductCard(
                        title: 'Fleece Lined Hoodie',
                        price: '£42.00',
                      ),
                      _CollectionProductCard(
                        title: 'Minimal Crest Hoodie',
                        price: '£36.00',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              width: double.infinity,
              color: Colors.grey[50],
              padding: const EdgeInsets.all(24),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Placeholder Footer',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Footer section',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
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
