import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback onLogoTap;
  final VoidCallback onSearchTap;
  final VoidCallback onAccountTap;
  final VoidCallback onCartTap;
  final VoidCallback onMenuTap;

  const AppHeader({
    super.key,
    required this.onLogoTap,
    required this.onSearchTap,
    required this.onAccountTap,
    required this.onCartTap,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Column(
        children: [
          // ---------------- TOP BANNER ----------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xFF4d2963),
            child: const Text(
              'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),

          // ---------------- MAIN HEADER ----------------
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // ---------------- LOGO ----------------
                  GestureDetector(
                    onTap: onLogoTap,
                    child: Image.network(
                      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                      height: 18,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          width: 18,
                          height: 18,
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 20),

                  // ---------------- NAVIGATION LINKS ----------------
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/'),
                        child: const Text(
                          'Home',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 8),

                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/about'),
                        child: const Text(
                          'About',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 8),

                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/collections'),
                        child: const Text(
                          'Shop',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // ---------------- HEADER ICON BUTTONS ----------------
                  IconButton(
                    icon: const Icon(Icons.search, size: 18, color: Colors.grey),
                    onPressed: onSearchTap,
                  ),
                  IconButton(
                    icon: const Icon(Icons.person_outline, size: 18, color: Colors.grey),
                    onPressed: onAccountTap,
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_bag_outlined, size: 18, color: Colors.grey),
                    onPressed: onCartTap,
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu, size: 18, color: Colors.grey),
                    onPressed: onMenuTap,
                  ),
                  IconButton(
                    icon: const Icon(Icons.print, size: 18, color: Colors.grey),
                    onPressed: () => Navigator.pushNamed(context, '/printshack'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
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
      price: '£0.00', // coursework only
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