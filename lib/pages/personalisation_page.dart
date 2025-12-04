// lib/pages/personalisation_page.dart
import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/footer.dart';
import '../services/cart_service.dart';
import '../models/product.dart';

class PersonalisationPage extends StatefulWidget {
  const PersonalisationPage({super.key});

  @override
  State<PersonalisationPage> createState() => _PersonalisationPageState();
}

class _PersonalisationPageState extends State<PersonalisationPage> {
  // ----- FORM STATE -----
  String _productType = 'hoodie';
  String _garmentColour = 'navy';
  String _printPosition = 'front';
  int _numLines = 1;
  String _line1 = '';
  String _line2 = '';
  String _line3 = '';
  String _fontStyle = 'block';
  String _fontColour = 'white';
  int _quantity = 1;

  final int _maxCharsPerLine = 20;


  // Simple gallery ()
  final List<String> _galleryImages = const [
    'https://via.placeholder.com/800x800?text=Print+Shack+1',
    'https://via.placeholder.com/800x800?text=Print+Shack+2',
    'https://via.placeholder.com/800x800?text=Print+Shack+3',
    'https://via.placeholder.com/800x800?text=Print+Shack+4',
  ];
  int _selectedImageIndex = 0;

  void _placeholder() {}

  bool get _isValid {
    if (_line1.trim().isEmpty) return false;
    if (_numLines >= 2 && _line2.trim().isEmpty) return false;
    if (_numLines >= 3 && _line3.trim().isEmpty) return false;
    return true;
  }

  void _addToCartDemo() {
    if (!_isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in the required text fields.'),
        ),
      );
      return;
    }

    final demoProduct = Product(
      id: 'print-demo',
      collectionSlug: 'print-shack',
      title: 'Personalised ${_productType.toUpperCase()} (Demo)',
      price: '£3.00', // demo pricing
      imageUrl: _galleryImages[_selectedImageIndex],
    );

    CartService.instance.addToCart(
      product: demoProduct,
      colour: _garmentColour,
      size: 'N/A',
      quantity: _quantity,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Personalised item added to cart (demo only).'),
      ),
    );
  }
Widget _buildLineField({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
  }) {
    final remaining = _maxCharsPerLine - value.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          maxLength: _maxCharsPerLine,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            counterText: '',
          ),
          onChanged: (text) {
            setState(() {
              onChanged(text);
            });
          },
        ),
        const SizedBox(height: 4),
        Text(
          '$remaining characters left',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

 @override
  Widget build(BuildContext context) {
    final linesPreview = [
      _line1,
      if (_numLines >= 2) _line2,
      if (_numLines >= 3) _line3,
    ].where((t) => t.trim().isNotEmpty).join('\n');

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
              onAccountTap: () => Navigator.pushNamed(context, '/login'),
              onCartTap: () => Navigator.pushNamed(context, '/cart'),
              onMenuTap: _placeholder,
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final bool isWide = constraints.maxWidth >= 900;


 // ----- LEFT: IMAGE GALLERY -----
                      final imageArea = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              _galleryImages[_selectedImageIndex],
                              width: isWide ? 480 : double.infinity,
                              height: isWide ? 480 : 260,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stack) {
                                return Container(
                                  width: isWide ? 480 : double.infinity,
                                  height: isWide ? 480 : 260,
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 48,
                                      color: Colors.black26,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 72,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _galleryImages.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 8),
                              itemBuilder: (context, index) {
                                final selected =
                                    index == _selectedImageIndex;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedImageIndex = index;
                                    });
                                  },
                                  child: Container(
                                    width: 72,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: selected
                                            ? const Color(0xFF4d2963)
                                            : Colors.grey[300]!,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.network(
                                        _galleryImages[index],
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stack) =>
                                                Container(
                                          color: Colors.grey[200],
                                          child: const Icon(
                                            Icons.broken_image,
                                            color: Colors.black26,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );


    
                      // ----- RIGHT: FORM COLUMN -----
                      final formColumn = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Personalise Text',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'From £3.00',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Tax included. Demo coursework only.',
                            style:
                                TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Add personalised text to your hoodie, T-shirt or sweatshirt. '
                            'Choose garment, colour and print position. This is a coursework demo only – '
                            'no real orders are processed.',
                            style: TextStyle(fontSize: 14, height: 1.6),
                          ),
                          const SizedBox(height: 24),

                          // Product type & colour
                          if (isWide)
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _productType,
                                    decoration: const InputDecoration(
                                      labelText: 'Product',
                                      border: OutlineInputBorder(),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                          value: 'hoodie',
                                          child: Text('Hoodie')),
                                      DropdownMenuItem(
                                          value: 'tshirt',
                                          child: Text('T-Shirt')),
                                      DropdownMenuItem(
                                          value: 'sweatshirt',
                                          child: Text('Sweatshirt')),
                                      DropdownMenuItem(
                                          value: 'other',
                                          child: Text('Other garment')),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _productType = v);
                                    },
                                  ),
                                ),

                              const SizedBox(width: 12),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _garmentColour,
                                    decoration: const InputDecoration(
                                      labelText: 'Garment colour',
                                      border: OutlineInputBorder(),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                          value: 'navy', child: Text('Navy')),
                                      DropdownMenuItem(
                                          value: 'black',
                                          child: Text('Black')),
                                      DropdownMenuItem(
                                          value: 'grey', child: Text('Grey')),
                                      DropdownMenuItem(
                                          value: 'white',
                                          child: Text('White')),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _garmentColour = v);
                                    },
                                  ),
                                ),
                              ],
                            )
                          else ...[
                            DropdownButtonFormField<String>(
                              value: _productType,
                              decoration: const InputDecoration(
                                labelText: 'Product',
                                border: OutlineInputBorder(),
                              ),
                              items: const [
                                DropdownMenuItem(
                                    value: 'hoodie', child: Text('Hoodie')),
                                DropdownMenuItem(
                                    value: 'tshirt', child: Text('T-Shirt')),
                                DropdownMenuItem(
                                    value: 'sweatshirt',
                                    child: Text('Sweatshirt')),
                                DropdownMenuItem(
                                    value: 'other',
                                    child: Text('Other garment')),
                              ],
                              onChanged: (v) {
                                if (v == null) return;
                                setState(() => _productType = v);
                              },
                            ),
                            const SizedBox(height: 12),
                            DropdownButtonFormField<String>(
                              value: _garmentColour,
                              decoration: const InputDecoration(
                                labelText: 'Garment colour',
                                border: OutlineInputBorder(),
                              ),
                              items: const [
                                DropdownMenuItem(
                                    value: 'navy', child: Text('Navy')),
                                DropdownMenuItem(
                                    value: 'black', child: Text('Black')),
                                DropdownMenuItem(
                                    value: 'grey', child: Text('Grey')),
                                DropdownMenuItem(
                                    value: 'white', child: Text('White')),
                              ],
                              onChanged: (v) {
                                if (v == null) return;
                                setState(() => _garmentColour = v);
                              },
                            ),
                          ],
                          const SizedBox(height: 16),


     // Print position & number of lines
                          if (isWide)
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _printPosition,
                                    decoration: const InputDecoration(
                                      labelText: 'Print position',
                                      border: OutlineInputBorder(),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                          value: 'front',
                                          child: Text('Front')),
                                      DropdownMenuItem(
                                          value: 'back', child: Text('Back')),
                                      DropdownMenuItem(
                                          value: 'sleeve',
                                          child:
                                              Text('Sleeve (demo option)')),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _printPosition = v);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: DropdownButtonFormField<int>(
                                    value: _numLines,
                                    decoration: const InputDecoration(
                                      labelText: 'Number of lines',
                                      border: OutlineInputBorder(),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                          value: 1, child: Text('1 line')),
                                      DropdownMenuItem(
                                          value: 2, child: Text('2 lines')),
                                      DropdownMenuItem(
                                          value: 3, child: Text('3 lines')),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _numLines = v);
                                    },
                                  ),
                                ),
                              ],
                            )
                          else ...[
                            DropdownButtonFormField<String>(
                              value: _printPosition,
                              decoration: const InputDecoration(
                                labelText: 'Print position',
                                border: OutlineInputBorder(),
                              ),
                              items: const [
                                DropdownMenuItem(
                                    value: 'front', child: Text('Front')),
                                DropdownMenuItem(
                                    value: 'back', child: Text('Back')),
                                DropdownMenuItem(
                                    value: 'sleeve',
                                    child: Text('Sleeve (demo option)')),
                              ],
                              onChanged: (v) {
                                if (v == null) return;
                                setState(() => _printPosition = v);
                              },
                            ),
                            const SizedBox(height: 12),
                            DropdownButtonFormField<int>(
                              value: _numLines,
                              decoration: const InputDecoration(
                                labelText: 'Number of lines',
                                border: OutlineInputBorder(),
                              ),
                              items: const [
                                DropdownMenuItem(
                                    value: 1, child: Text('1 line')),
                                DropdownMenuItem(
                                    value: 2, child: Text('2 lines')),
                                DropdownMenuItem(
                                    value: 3, child: Text('3 lines')),
                              ],
                              onChanged: (v) {
                                if (v == null) return;
                                setState(() => _numLines = v);
                              },
                            ),
                          ],
                          const SizedBox(height: 16),

     // Dynamic text fields
                          _buildLineField(
                            label: 'Line 1 text',
                            value: _line1,
                            onChanged: (t) => _line1 = t,
                          ),
                          if (_numLines >= 2)
                            _buildLineField(
                              label: 'Line 2 text',
                              value: _line2,
                              onChanged: (t) => _line2 = t,
                            ),
                          if (_numLines >= 3)
                            _buildLineField(
                              label: 'Line 3 text',
                              value: _line3,
                              onChanged: (t) => _line3 = t,
                            ),


                          // Font style & print colour
                          if (isWide)
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _fontStyle,
                                    decoration: const InputDecoration(
                                      labelText: 'Font style',
                                      border: OutlineInputBorder(),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                          value: 'block',
                                          child: Text('Block')),
                                      DropdownMenuItem(
                                          value: 'script',
                                          child: Text('Script')),
                                      DropdownMenuItem(
                                          value: 'sport',
                                          child: Text('Sport')),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _fontStyle = v);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _fontColour,
                                    decoration: const InputDecoration(
                                      labelText: 'Print colour',
                                      border: OutlineInputBorder(),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                          value: 'white',
                                          child: Text('White')),
                                      DropdownMenuItem(
                                          value: 'gold', child: Text('Gold')),
                                      DropdownMenuItem(
                                          value: 'purple',
                                          child: Text('Union purple')),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _fontColour = v);
                                    },
                                  ),
                                ),
                              ],
                            )
                          else ...[
                            DropdownButtonFormField<String>(
                              value: _fontStyle,
                              decoration: const InputDecoration(
                                labelText: 'Font style',
                                border: OutlineInputBorder(),
                              ),
                              items: const [
                                DropdownMenuItem(
                                    value: 'block', child: Text('Block')),
                                DropdownMenuItem(
                                    value: 'script', child: Text('Script')),
                                DropdownMenuItem(
                                    value: 'sport', child: Text('Sport')),
                              ],
                              onChanged: (v) {
                                if (v == null) return;
                                setState(() => _fontStyle = v);
                              },
                            ),
                            const SizedBox(height: 12),
                            DropdownButtonFormField<String>(
                              value: _fontColour,
                              decoration: const InputDecoration(
                                labelText: 'Print colour',
                                border: OutlineInputBorder(),
                              ),
                              items: const [
                                DropdownMenuItem(
                                    value: 'white', child: Text('White')),
                                DropdownMenuItem(
                                    value: 'gold', child: Text('Gold')),
                                DropdownMenuItem(
                                    value: 'purple',
                                    child: Text('Union purple')),
                              ],
                              onChanged: (v) {
                                if (v == null) return;
                                setState(() => _fontColour = v);
                              },
                            ),
                          ],
                          const SizedBox(height: 16),

 // Quantity + add to cart
                          Row(
                            children: [
                              const Text(
                                'Quantity',
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove, size: 18),
                                      onPressed: _quantity > 1
                                          ? () {
                                              setState(
                                                () => _quantity--,
                                              );
                                            }
                                          : null,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                    Text('$_quantity'),
                                    IconButton(
                                      icon: const Icon(Icons.add, size: 18),
                                      onPressed: () {
                                        setState(() => _quantity++);
                                      },
                                      visualDensity: VisualDensity.compact,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isValid ? _addToCartDemo : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4d2963),
                                foregroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: const Text(
                                'Add personalised item to cart',
                                style: TextStyle(
                                  letterSpacing: 0.5,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'This is a demo – no real orders are processed.',
                            style:
                                TextStyle(fontSize: 12, color: Colors.grey),
                          ),

                          const SizedBox(height: 16),
                          const Text(
                            'This is an approximate preview of how your text will appear.',
                            style:
                                TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: Container(
                              width: isWide ? 420 : double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                linesPreview.isEmpty
                                    ? 'Your text will appear here'
                                    : linesPreview,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),
                          const Text(
                            'How our personalisation works',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '• Pricing from £3.00 per item (demo pricing).\n'
                            '• Typical turnaround: 2–5 working days (demo estimate).\n'
                            '• We can print on T-shirts, hoodies and sweatshirts in this demo.\n'
                            '• This service is provided for coursework demonstration only.',
                            style: TextStyle(fontSize: 13, height: 1.5),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Important',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '• Please check spelling carefully – you are responsible for text accuracy.\n'
                            '• Personalised items are non-refundable in this demo scenario.',
                            style: TextStyle(fontSize: 13, height: 1.5),
                          ),
                          const SizedBox(height: 24),
                        ],
                      );

                      if (isWide) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 5, child: imageArea),
                            const SizedBox(width: 32),
                            Expanded(flex: 6, child: formColumn),
                          ],
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          imageArea,
                          const SizedBox(height: 24),
                          formColumn,
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),

            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

