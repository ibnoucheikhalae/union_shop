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
  // Simple demo state
  String _productType = 'hoodie';
  String _garmentColour = 'navy';
  String _printPosition = 'front';
  int _numLines = 1;
  String _line1 = '';
  String _line2 = '';
  String _line3 = '';
  String _fontStyle = 'block';
  String _fontColour = 'white';

  final _maxCharsPerLine = 20;

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

    // Dummy product – in a real app you’d look this up from your data.
    final demoProduct = Product(
      id: 'print-demo',
      collectionSlug: 'print-shack',
      title: 'Personalised ${_productType.toUpperCase()} (Demo)',
      price: '£3.00', // coursework only
      imageUrl: 'https://via.placeholder.com/400x400?text=Personalised+Demo',
    );

    CartService.instance.addToCart(
      product: demoProduct,
      colour: _garmentColour,
      size: 'N/A',
      quantity: 1,
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
            counterText: '', // hide default counter
          ),
          onChanged: (text) => setState(() => onChanged(text)),
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
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Personalise Your Text',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Use this demo form to design a personalised item. '
                    'Options and prices are placeholders – no real orders '
                    'are processed.',
                    style: TextStyle(fontSize: 14, height: 1.6),
                  ),
                  const SizedBox(height: 24),

                  // Product type & colour
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
                              child: Text('Hoodie'),
                            ),
                            DropdownMenuItem(
                              value: 'tshirt',
                              child: Text('T-Shirt'),
                            ),
                            DropdownMenuItem(
                              value: 'sweatshirt',
                              child: Text('Sweatshirt'),
                            ),
                            DropdownMenuItem(
                              value: 'other',
                              child: Text('Other garment'),
                            ),
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
                              value: 'navy',
                              child: Text('Navy'),
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
                              value: 'white',
                              child: Text('White'),
                            ),
                          ],
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() => _garmentColour = v);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Print position & number of lines
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
                              child: Text('Front'),
                            ),
                            DropdownMenuItem(
                              value: 'back',
                              child: Text('Back'),
                            ),
                            DropdownMenuItem(
                              value: 'sleeve',
                              child: Text('Sleeve (demo)'),
                            ),
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
                              value: 1,
                              child: Text('1 line'),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text('2 lines'),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text('3 lines'),
                            ),
                          ],
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() => _numLines = v);
                          },
                        ),
                      ),
                    ],
                  ),
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

                  // Font style & colour
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
                              child: Text('Block'),
                            ),
                            DropdownMenuItem(
                              value: 'script',
                              child: Text('Script'),
                            ),
                            DropdownMenuItem(
                              value: 'sport',
                              child: Text('Sport'),
                            ),
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
                              child: Text('White'),
                            ),
                            DropdownMenuItem(
                              value: 'gold',
                              child: Text('Gold'),
                            ),
                            DropdownMenuItem(
                              value: 'purple',
                              child: Text('Union purple'),
                            ),
                          ],
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() => _fontColour = v);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Live summary “preview”
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[50],
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Preview summary (demo)',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Product: ${_productType.toUpperCase()}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Garment colour: $_garmentColour',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Print position: $_printPosition',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Font: $_fontStyle / $_fontColour',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          color: Colors.black,
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

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
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                      child: const Text(
                        'ADD PERSONALISED ITEM TO CART (DEMO)',
                        style: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 13,
                        ),
                      ),
                    ),
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

