import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/footer.dart';
import '../data/dummy_products.dart';
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
  onCartTap: () {
    Navigator.pushNamed(context, '/cart'); // 👈 NEW
  },
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
                              child: const Text('Most popular'),
                            ),
                            DropdownMenuItem(
                              value: 'price_low_high',
                              child: const Text('Price: Low to High'),
                            ),
                            DropdownMenuItem(
                              value: 'price_high_low',
                              child: const Text('Price: High to Low'),
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
                              child: const Text('All sizes'),
                            ),
                            DropdownMenuItem(
                              value: 's',
                              child: const Text('S'),
                            ),
                            DropdownMenuItem(
                              value: 'm',
                              child: const Text('M'),
                            ),
                            DropdownMenuItem(
                              value: 'l',
                              child: const Text('L'),
                            ),
                            DropdownMenuItem(
                              value: 'xl',
                              child: const Text('XL'),
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
                              child: const Text('All colours'),
                            ),
                            DropdownMenuItem(
                              value: 'black',
                              child: const Text('Black'),
                            ),
                            DropdownMenuItem(
                              value: 'grey',
                              child: const Text('Grey'),
                            ),
                            DropdownMenuItem(
                              value: 'navy',
                              child: const Text('Navy'),
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
                              child: const Text('All fits'),
                            ),
                            DropdownMenuItem(
                              value: 'regular',
                              child: const Text('Regular'),
                            ),
                            DropdownMenuItem(
                              value: 'oversized',
                              child: const Text('Oversized'),
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
                    children: dummyProducts
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

              // Reusable Footer
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
