// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/footer.dart';
import '../widgets/product_card.dart';

void _placeholder() {}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _goToCollections(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Reusable header
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

            // ==== HERO – "Essential Range - Over 20% OFF!" ====
            SizedBox(
              height: 380,
              width: double.infinity,
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: Image.network(
                      'https://shop.upsu.net/cdn/shop/files/Essential_Tshirt_1.jpg', // any hero image
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  // Dark overlay
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                  // Text + button
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Essential Range - Over 20% OFF!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Over 20% off our Essential Range. Come and grab yours while stock lasts!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () => _goToCollections(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4d2963),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 14,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: const Text(
                            'BROWSE COLLECTION',
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ==== ESSENTIAL RANGE SECTION ====
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'ESSENTIAL RANGE – OVER 20% OFF!',
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 800 ? 2 : 1,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 32,
                    childAspectRatio: 4 / 3,
                    children: const [
                      ProductCard(
                        id: 'essential-hoodie',
                        collectionSlug: 'essential',
                        title: 'Limited Edition Essential Zip Hoodies',
                        price: '£14.99',
                        imageUrl:
                            'https://shop.upsu.net/cdn/shop/files/Essential_Zip_1.jpg',
                      ),
                      ProductCard(
                        id: 'essential-tshirt',
                        collectionSlug: 'essential',
                        title: 'Essential T-Shirt',
                        price: '£6.99',
                        imageUrl:
                            'https://shop.upsu.net/cdn/shop/files/Essential_Tshirt_2.jpg',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            