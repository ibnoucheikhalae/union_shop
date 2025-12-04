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

  void _openPrintShackMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text('Print Shack'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(ctx); // close dialog
                Navigator.pushNamed(context, '/printshack');
              },
              child: const Text('About Print Shack'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(ctx); // close dialog
                Navigator.pushNamed(context, '/personalisation');
              },
              child: const Text('Personalise Text'),
            ),
          ],
        );
      },
    );
  }

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
                  // LOGO
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

                  // NAV LINKS
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
                        onPressed: () =>
                            Navigator.pushNamed(context, '/collections'),
                        child: const Text(
                          'Shop',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 8),

                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/sale'),
                        child: const Text(
                          'Sale',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 8),

                      TextButton(
                        onPressed: () => _openPrintShackMenu(context),
                        child: const Text(
                          'Print Shack',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // ICONS
                  IconButton(
                    icon:
                        const Icon(Icons.search, size: 18, color: Colors.grey),
                    onPressed: onSearchTap,
                  ),
                  IconButton(
                    icon: const Icon(Icons.person_outline,
                        size: 18, color: Colors.grey),
                    onPressed: onAccountTap,
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_bag_outlined,
                        size: 18, color: Colors.grey),
                    onPressed: onCartTap,
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.menu, size: 18, color: Colors.grey),
                    onPressed: onMenuTap,
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
