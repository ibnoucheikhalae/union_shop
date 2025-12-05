// lib/pages/product_page.dart
import 'package:flutter/material.dart';

import '../widgets/app_header.dart';
import '../widgets/footer.dart';
import '../data/dummy_products.dart';
import '../models/product.dart';
import '../services/cart_service.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Product product;

  String? _selectedColour;
  String? _selectedSize;
  int _quantity = 1;

  void _placeholder() {}

  @override
  void initState() {
    super.initState();

    // For now just take the first dummy product.
    // Later you can pass product via Navigator arguments.
    product = dummyProducts.first;

    // Optional sensible defaults
    _selectedColour =
        product.colours.isNotEmpty ? product.colours.first : null;
    _selectedSize = product.sizes.isNotEmpty ? product.sizes.first : null;
  }

  Future<void> _addToCart() async {
    if (_selectedColour == null || _selectedSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please choose colour and size first.'),
        ),
      );
      return;
    }

    await CartService.instance.addToCart(
      product: product,
      colour: _selectedColour!,
      size: _selectedSize!,
      quantity: _quantity,
    );

    // Navigate to cart so user sees result
    Navigator.pushNamed(context, '/cart');
  }

  @override
  Widget build(BuildContext context) {
    // Allow deep-linking: read optional productId from route arguments.
    final args = ModalRoute.of(context)?.settings.arguments;
    String? productId;
    if (args is String) {
      productId = args;
    } else if (args is Map && args['productId'] is String) {
      productId = args['productId'] as String;
    }

    final Product effectiveProduct = (productId != null)
        ? dummyProducts.firstWhere(
            (p) => p.id == productId,
            orElse: () => dummyProducts.first,
          )
        : product;

    // Update local product reference for the page (safe during build).
    product = effectiveProduct;

    // Ensure sensible defaults for selectors when product changes.
    _selectedColour = _selectedColour ?? (product.colours.isNotEmpty ? product.colours.first : null);
    _selectedSize = _selectedSize ?? (product.sizes.isNotEmpty ? product.sizes.first : null);

    // Parse numeric price for layout if you want it
    final priceText = product.price; // already includes £

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

            // Back link to return to previous collection or listing
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back to collection'),
                ),
              ),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 800;

                  if (isWide) {
                    // Side-by-side image + details (desktop-ish)
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        Expanded(
                          flex: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                              child: AspectRatio(
                              aspectRatio: 4 / 3,
                              child: (product.imageUrl != null &&
                                      product.imageUrl!.isNotEmpty)
                                  ? Image.network(
                                      product.imageUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, _, __) {
                                        return Container(
                                          color: Colors.grey[300],
                                          child: const Center(
                                            child: Icon(
                                              Icons.image_not_supported,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      color: Colors.grey[300],
                                      child: const Center(
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 32),

                        // Details
                        Expanded(
                          flex: 4,
                          child: _buildDetails(priceText),
                        ),
                      ],
                    );
                  }

                  // Mobile / narrow: stacked
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                          child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: (product.imageUrl != null &&
                                  product.imageUrl!.isNotEmpty)
                              ? Image.network(
                                  product.imageUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, _, __) {
                                    return Container(
                                      color: Colors.grey[300],
                                      child: const Center(
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildDetails(priceText),
                    ],
                  );
                },
              ),
            ),

            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetails(String priceText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          priceText,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4d2963),
          ),
        ),
        const SizedBox(height: 16),

        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.description ?? '',
          style: const TextStyle(
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),

        // Colour dropdown
        if (product.colours.isNotEmpty) ...[
          const Text(
            'Colour',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedColour,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: product.colours
                .map(
                  (c) => DropdownMenuItem(
                    value: c,
                    child: Text(c),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedColour = value;
              });
            },
          ),
          const SizedBox(height: 16),
        ],

        // Size dropdown
        if (product.sizes.isNotEmpty) ...[
          const Text(
            'Size',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedSize,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: product.sizes
                .map(
                  (s) => DropdownMenuItem(
                    value: s,
                    child: Text(s),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedSize = value;
              });
            },
          ),
          const SizedBox(height: 16),
        ],

        // Quantity selector
        const Text(
          'Quantity',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              onPressed: _quantity > 1
                  ? () {
                      setState(() {
                        _quantity--;
                      });
                    }
                  : null,
              icon: const Icon(Icons.remove),
            ),
            Text('$_quantity'),
            IconButton(
              onPressed: () {
                setState(() {
                  _quantity++;
                });
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Add to cart
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _addToCart,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4d2963),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: const Text(
              'ADD TO CART',
              style: TextStyle(
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
