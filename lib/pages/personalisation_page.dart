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
