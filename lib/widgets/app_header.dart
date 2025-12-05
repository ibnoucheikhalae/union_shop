import 'package:flutter/material.dart';
import '../services/cart_service.dart';

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

  @override
  Widget build(BuildContext context) {
    final cartItemCount = _cart.itemCount;

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
                  // LOGO
                  GestureDetector(
                    onTap: widget.onLogoTap,
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
                            child: Icon(Icons.image_not_supported, color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 20),

                  // ---------------- NAVIGATION LINKS ----------------
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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

                      // ---------------- SHOP DROPDOWN ----------------
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          Navigator.pushNamed(
                            context, 
                            '/collection',
                            arguments: value,
                          );
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem<String>(
                            value: 'sportswear',
                            child: Text('Sportswear'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'hoodies',
                            child: Text('Hoodies & Sweatshirts'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'stationery',
                            child: Text('Stationery'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'gifts',
                            child: Text('Gifts & Accessories'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'campus-essentials',
                            child: Text('Campus Essentials'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'sale',
                            child: Text('Sale Items'),
                          ),
                        ],
                        child: InkWell(
                          child: Row(
                            children: const [
                              Text('Shop',
                                  style: TextStyle(color: Colors.black)),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_drop_down,
                                  size: 18, color: Colors.black),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // ---------------- PRINT SHACK DROPDOWN ----------------
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'about') {
                            Navigator.pushNamed(context, '/printshack');
                          } else if (value == 'personalise') {
                            Navigator.pushNamed(context, '/personalisation');
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem<String>(
                            value: 'about',
                            child: Text('About Print Shack'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'personalise',
                            child: Text('Personalisation'),
                          ),
                        ],
                        child: InkWell(
                          child: Row(
                            children: const [
                              Text('The Print Shack',
                                  style: TextStyle(color: Colors.black)),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_drop_down,
                                  size: 18, color: Colors.black),
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
                  ),

                  const Spacer(),

                  // ---------------- ACTION ICONS ----------------
                  IconButton(
                    icon: const Icon(Icons.search, size: 18, color: Colors.grey),
                    onPressed: () {
                      Navigator.pushNamed(context, '/search');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.person_outline, size: 18, color: Colors.grey),
                    onPressed: widget.onAccountTap,
                  ),
                  // Cart icon with badge
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_bag_outlined, size: 18, color: Colors.grey),
                        onPressed: widget.onCartTap,
                      ),
                      if (cartItemCount > 0)
                        Positioned(
                          right: 4,
                          top: 4,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFF4d2963),
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 18,
                              minHeight: 18,
                            ),
                            child: Text(
                              cartItemCount > 99 ? '99+' : '$cartItemCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu, size: 18, color: Colors.grey),
                    onPressed: widget.onMenuTap,
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
