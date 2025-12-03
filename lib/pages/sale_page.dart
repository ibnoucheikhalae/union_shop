import 'package:flutter/material.dart';
import '../widgets/app_header.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});

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
                    context, '/', (route) => false);
              },
              onSearchTap: _placeholder,
              onAccountTap: _placeholder,
              onCartTap: _placeholder,
              onMenuTap: _placeholder,
            ),
           const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'SALE',
                Padding(
  padding: const EdgeInsets.symmetric(horizontal: 24.0),
  child: GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    childAspectRatio: 3 / 4,
      children: const [
      _SaleItemCard(
        title: 'Classic Hoodie',
        oldPrice: '£40.00',
        salePrice: '£28.00',
      ),
      _SaleItemCard(
        title: 'Campus Sweatshirt',
        oldPrice: '£35.00',
        salePrice: '£25.00',
      ),
      _SaleItemCard(
        title: 'Zip Hoodie',
        oldPrice: '£42.00',
        salePrice: '£30.00',
      ),
      _SaleItemCard(
        title: 'Lightweight Hoodie',
        oldPrice: '£38.00',
        salePrice: '£26.00',
      ),
    ],
  ),
),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Products will come later
          ],
        ),
      ),
    );
  }
}