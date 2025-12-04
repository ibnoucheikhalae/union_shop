// lib/pages/sale_page.dart
import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/footer.dart';
class SalePage extends StatelessWidget {
  const SalePage({super.key});

  void _placeholder() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
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
    Navigator.pushNamed(context, '/cart'); // 👈 NEW
  },
  onMenuTap: _placeholder,
),


            // SALE title
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'SALE',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Grid of sale items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount:
                    MediaQuery.of(context).size.width > 600 ? 3 : 2,
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

            const SizedBox(height: 24),

       // Reusable Footer
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

class _SaleItemCard extends StatelessWidget {
  final String title;
  final String oldPrice;
  final String salePrice;

  const _SaleItemCard({
    required this.title,
    required this.oldPrice,
    required this.salePrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                'Image',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              oldPrice,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              salePrice,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
