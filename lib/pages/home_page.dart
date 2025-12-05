
// lib/pages/home_page.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/app_header.dart';
import '../widgets/footer.dart';
import '../widgets/product_card.dart';

void _placeholder() {}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentCarouselIndex = 0;
  final PageController _pageController = PageController();
  Timer? _carouselTimer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        final nextPage = (_currentCarouselIndex + 1) % 4;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _goToCollections() {
    Navigator.pushNamed(context, '/collections');
  }

  void _goToSale() {
    Navigator.pushNamed(context, '/sale');
  }

  void _goToPrintShack() {
    Navigator.pushNamed(context, '/personalisation');
  }

  Future<void> _launchDominos() async {
    final Uri url = Uri.parse('https://www.dominos.co.uk');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open Dominos website')),
        );
      }
    }
  }

  Widget _buildCarouselSlide({
    required String imageUrl,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Image.network(
            imageUrl,
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
          bottom: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onPressed,
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
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
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

            // ==== CAROUSEL HERO ====
            SizedBox(
              height: 450,
              width: double.infinity,
              child: Stack(
                children: [
                  // PageView for carousel slides
                  PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentCarouselIndex = index;
                      });
                    },
                    children: [
                      // Slide 1: Collections
                      _buildCarouselSlide(
                        imageUrl: 'https://shop.upsu.net/cdn/shop/files/Pink_Essential_Hoodie_2a3589c2-096f-479f-ac60-d41e8a853d04_1080x.jpg?v=1749131089',
                        title: 'Explore Our Collections',
                        subtitle: 'Discover hoodies, accessories, stationery & more',
                        buttonText: 'SHOP NOW',
                        onPressed: _goToCollections,
                      ),
                      // Slide 2: Print Shack
                      _buildCarouselSlide(
                        imageUrl: 'https://shop.upsu.net/cdn/shop/files/CloseUp_1024x1024@2x.jpg?v=1614736784',
                        title: 'Print Shack',
                        subtitle: 'Custom printing services for all your needs',
                        buttonText: 'LEARN MORE',
                        onPressed: _goToPrintShack,
                      ),
                      // Slide 3: Sale
                      _buildCarouselSlide(
                        imageUrl: 'https://images.asos-media.com/products/the-couture-club-co-ord-oversized-hoodied-zip-through-hoodie-in-off-white/205193706-1-white?\$n_640w\$&wid=513&fit=constrain',
                        title: 'Sale - Up to 50% OFF!',
                        subtitle: 'Limited time offers on selected items',
                        buttonText: 'SHOP SALE',
                        onPressed: _goToSale,
                      ),
                      // Slide 4: Dominos
                      _buildCarouselSlide(
                        imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=1200',
                        title: 'Order Domino\'s Pizza',
                        subtitle: 'Quick delivery straight to campus',
                        buttonText: 'ORDER NOW',
                        onPressed: _launchDominos,
                      ),
                    ],
                  ),
                  // Carousel indicators (dots)
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        return GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentCarouselIndex == index ? 24 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _currentCarouselIndex == index
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
                      }),
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
                        MediaQuery.of(context).size.width > 800 ? 3 : 1,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 32,
                    childAspectRatio: 0.75,
                    children: const [
                      ProductCard(
                        id: 'essential-hoodie',
                        collectionSlug: 'essential',
                        title: 'Limited Edition Essential Zip Hoodies',
                        price: '£14.99',
                        imageUrl:
                            'https://i5.walmartimages.com/seo/Womens-Oversized-Hoodies-Fleece-Sweatshirts-Long-Sleeve-Sweaters-Pullover-Fall-Outfits-with-Pocket_f7e46bfd-ffd7-4468-92d4-77505d811915.f8c37ec4a3a4c124107ac2eb5ddebaa2.jpeg',
                      ),
                      ProductCard(
                        id: 'essential-tshirt',
                        collectionSlug: 'essential',
                        title: 'Essential T-Shirt',
                        price: '£6.99',
                        imageUrl:
                            'https://m.media-amazon.com/images/I/61ExObQ54eL._AC_UY1000_.jpg',
                      ),
                      ProductCard(
                        id: 'essential-sweatshirt',
                        collectionSlug: 'essential',
                        title: 'Essential Sweatshirt',
                        price: '£18.99',
                        imageUrl:
                            'https://www.themercantilelondon.com/cdn/shop/files/4_98371666-c727-45cd-9c73-5b6d0e992de1.jpg?v=1752837826&width=1200',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            
            // ==== SIGNATURE RANGE SECTION ====
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'SIGNATURE RANGE',
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
                        MediaQuery.of(context).size.width > 800 ? 3 : 1,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 32,
                    childAspectRatio: 0.75,
                    children: const [
                      ProductCard(
                        id: 'signature-hoodie',
                        collectionSlug: 'signature',
                        title: 'Signature Hoodie',
                        price: '£32.99',
                        imageUrl:
                            'assets/images/product/bluehoodie.png',
                      ),
                      ProductCard(
                        id: 'signature-sweatshirt',
                        collectionSlug: 'signature',
                        title: 'Signature T-Shirt',
                        price: '£14.99',
                        imageUrl:
                            'assets/images/product/zipup.png',
                      ),
                      ProductCard(
                        id: 'signature-jacket',
                        collectionSlug: 'signature',
                        title: 'Signature Jacket',
                        price: '£45.99',
                        imageUrl:
                            'assets/images/product/greenhoodie.png',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ==== PORTSMOUTH CITY COLLECTION ====
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Column(
                children: [
                  const Text(
                    'PORTSMOUTH CITY COLLECTION',
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
                        MediaQuery.of(context).size.width > 900 ? 4 : 2,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 32,
                    childAspectRatio: 0.75,
                    children: const [
                      ProductCard(
                        id: 'portsmouth-magnet',
                        collectionSlug: 'portsmouth-city',
                        title: 'Portsmouth City Magnet',
                        price: '£4.50',
                        imageUrl:
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1080x.jpg?v=1752230282',
                      ),
                      ProductCard(
                        id: 'portsmouth-postcard',
                        collectionSlug: 'portsmouth-city',
                        title: 'Portsmouth City Postcard',
                        price: '£1.00',
                        imageUrl:
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1080x.jpg?v=1752232561',
                      ),
                      ProductCard(
                        id: 'portsmouth-bookmark',
                        collectionSlug: 'portsmouth-city',
                        title: 'Portsmouth City Bookmark',
                        price: '£3.00',
                        imageUrl:
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityBookmark1_1080x.jpg?v=1752230004',
                      ),
                      ProductCard(
                        id: 'portsmouth-notebook',
                        collectionSlug: 'portsmouth-city',
                        title: 'Portsmouth City Notebook',
                        price: '£7.50',
                        imageUrl:
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityNotebook_1024x1024@2x.jpg?v=1757419215',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ==== ADD A PERSONAL TOUCH ====
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: MediaQuery.of(context).size.width > 800
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image on the left
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://shop.upsu.net/cdn/shop/files/CloseUp_1024x1024@2x.jpg?v=1614736784',
                              fit: BoxFit.cover,
                              height: 300,
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                        // Text content on the right
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Add a Personal Touch',
                                style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'First add your item of clothing to your cart then click below to add your text!\nOne line of text contains 10 characters!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/personalisation');
                                },
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
                                  'CLICK HERE TO ADD TEXT!',
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
                    )
                  : Column(
                      children: [
                        // Image on top for mobile
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://shop.upsu.net/cdn/shop/files/CloseUp_1024x1024@2x.jpg?v=1614736784',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 250,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Add a Personal Touch',
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'First add your item of clothing to your cart then click below to add your text!\nOne line of text contains 10 characters!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/personalisation');
                          },
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
                            'CLICK HERE TO ADD TEXT!',
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 1,
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

class _RangeTile extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _RangeTile({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          Center(
            child: Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
