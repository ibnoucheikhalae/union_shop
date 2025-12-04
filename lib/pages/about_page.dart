// lib/pages/about_page.dart
import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/footer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  void _placeholder() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ======= REUSABLE HEADER =======
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

            // ======= MAIN STATIC ABOUT CONTENT =======
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About The Union Shop',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'The Union Shop is part of the University of Portsmouth Student\' s Union. '
                    'We exist to support and celebrate student life. Offering official branded '
                    'clothing, merchandise, stationery, graduation gifts, and personalised items.\n',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),

                  const Text(
                    'Our mission is to provide affordable, high-quality products that help students '
                    'feel connected to the University community. Whether you need a hoodie for winter, '
                    'a branded gift for a friend, or essentials for your studies, the Union Shop has '
                    'something for everyone.\n',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),

                  const Text(
                    'We reinvest profits back into student services, activities, and support, meaning every '
                    'purchase contributes to enhancing the student experience.\n',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),

                  const SizedBox(height: 24),

                  
                  const Text(
                    'If you have questions about orders, products, or sizing. Email us at: union.shop@port.ac.uk\n'
                    'Or visit the Student\' s Union building for in-person support.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),

            // ======= REUSABLE FOOTER =======
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
