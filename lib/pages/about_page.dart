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
                    'The Union Shop is part of the University of Portsmouth Students\' Union. '
                    'We exist to support and celebrate student life — offering official branded '
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
                    'Opening Hours',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Term Time:\n'
                    'Monday – Friday: 10am – 4pm\n\n'
                    'Consolidation / Outside Term Time:\n'
                    'Monday – Friday: 10am – 3pm\n\n'
                    'Online store available 24/7.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Have questions about orders, products, or sizing?\n'
                    'Email us at: union.shop@port.ac.uk\n'
                    'Or visit the Students\' Union building for in-person support.',
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
