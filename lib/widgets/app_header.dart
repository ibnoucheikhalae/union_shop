import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppHeader extends StatefulWidget {
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
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  final CartService _cart = CartService.instance;
  final AuthService _authService = AuthService();

  void _handleAccountTap() {
    final user = _authService.currentUser;
    if (user != null) {
      Navigator.pushNamed(context, '/account');
    } else {
      widget.onAccountTap();
    }
  }

  void _showMobileMenu() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
            ExpansionTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Shop'),
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 72),
                  title: const Text('Sportswear'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/collection', arguments: 'sportswear');
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 72),
                  title: const Text('Hoodies & Sweatshirts'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/collection', arguments: 'hoodies');
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 72),
                  title: const Text('Stationery'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/collection', arguments: 'stationery');
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 72),
                  title: const Text('Gifts & Accessories'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/collection', arguments: 'gifts');
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 72),
                  title: const Text('Campus Essentials'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/collection', arguments: 'campus-essentials');
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 72),
                  title: const Text('Sale Items'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/collection', arguments: 'sale');
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.print),
              title: const Text('The Print Shack'),
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 72),
                  title: const Text('About Print Shack'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/printshack');
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 72),
                  title: const Text('Personalisation'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/personalisation');
                  },
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.local_offer),
              title: const Text('Sale'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/sale');
              },
            ),
          ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartItemCount = _cart.itemCount;
    final isMobile = MediaQuery.of(context).size.width < 1000;

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ---------------- TOP BANNER ----------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            color: const Color(0xFF4d2963),
            child: Text(
              isMobile 
                ? 'BIG SALE! OVER 20% OFF!'
                : 'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white, 
                fontSize: isMobile ? 11 : 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // ---------------- MAIN HEADER ----------------
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                // LOGO
                GestureDetector(
                  onTap: widget.onLogoTap,
                  child: Image.network(
                    'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                    height: isMobile ? 30 : 40,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        width: isMobile ? 30 : 40,
                        height: isMobile ? 30 : 40,
                        child: const Center(
                          child: Icon(Icons.image_not_supported, color: Colors.grey, size: 16),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 8),

                // ---------------- DESKTOP NAVIGATION ----------------
                if (!isMobile) ...[
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/'),
                    child: const Text('Home', style: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(width: 8),

                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/about'),
                    child: const Text('About', style: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(width: 8),

                  // Shop Dropdown
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      Navigator.pushNamed(context, '/collection', arguments: value);
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'sportswear', child: Text('Sportswear')),
                      const PopupMenuItem(value: 'hoodies', child: Text('Hoodies & Sweatshirts')),
                      const PopupMenuItem(value: 'stationery', child: Text('Stationery')),
                      const PopupMenuItem(value: 'gifts', child: Text('Gifts & Accessories')),
                      const PopupMenuItem(value: 'campus-essentials', child: Text('Campus Essentials')),
                      const PopupMenuItem(value: 'sale', child: Text('Sale Items')),
                    ],
                    child: InkWell(
                      child: Row(
                        children: const [
                          Text('Shop', style: TextStyle(color: Colors.black)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_drop_down, size: 18, color: Colors.black),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Print Shack Dropdown
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'about') {
                        Navigator.pushNamed(context, '/printshack');
                      } else if (value == 'personalise') {
                        Navigator.pushNamed(context, '/personalisation');
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'about', child: Text('About Print Shack')),
                      const PopupMenuItem(value: 'personalise', child: Text('Personalisation')),
                    ],
                    child: InkWell(
                      child: Row(
                        children: const [
                          Text('The Print Shack', style: TextStyle(color: Colors.black)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_drop_down, size: 18, color: Colors.black),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/sale'),
                    child: const Text('Sale', style: TextStyle(color: Colors.black)),
                  ),
                ],

                const Spacer(),

                // ---------------- ACTION ICONS ----------------
                IconButton(
                  icon: Icon(Icons.search, size: isMobile ? 20 : 22, color: Colors.grey),
                  padding: EdgeInsets.all(isMobile ? 4 : 8),
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  },
                ),
                if (!isMobile)
                  StreamBuilder<User?>(
                    stream: _authService.authStateChanges,
                    builder: (context, snapshot) {
                      final isLoggedIn = snapshot.data != null;
                      return IconButton(
                        icon: Icon(
                          isLoggedIn ? Icons.person : Icons.person_outline,
                          size: 22,
                          color: isLoggedIn ? const Color(0xFF4d2963) : Colors.grey,
                        ),
                        onPressed: _handleAccountTap,
                      );
                    },
                  ),
                // Cart icon with badge
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_bag_outlined, size: isMobile ? 20 : 22, color: Colors.grey),
                      padding: EdgeInsets.all(isMobile ? 4 : 8),
                      constraints: const BoxConstraints(),
                      onPressed: widget.onCartTap,
                    ),
                    if (cartItemCount > 0)
                      Positioned(
                        right: 2,
                        top: 2,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: Color(0xFF4d2963),
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            cartItemCount > 99 ? '99+' : '$cartItemCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                // Menu icon - only on mobile
                if (isMobile)
                  IconButton(
                    icon: const Icon(Icons.menu, size: 26, color: Colors.black87),
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(),
                    onPressed: _showMobileMenu,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
