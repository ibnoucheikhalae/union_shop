// lib/pages/cart_page.dart
import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/footer.dart';
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void _placeholder() {}

  @override
  Widget build(BuildContext context) {
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
  onAccountTap: _placeholder,
  onCartTap: () {
    Navigator.pushNamed(context, '/cart'); // 👈 NEW
  },
  onMenuTap: _placeholder,
),


            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Your Cart',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                   Text(
                    'Your shopping cart is currently empty.\n\n'
                    'In later stages of the coursework, this page will show '
                    'a list of selected products, quantities, and a checkout summary.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
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
