import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/footer.dart';

class PrintShackAboutPage extends StatelessWidget {
  const PrintShackAboutPage({super.key});

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
              onAccountTap: () => Navigator.pushNamed(context, '/login'),
              onCartTap: () => Navigator.pushNamed(context, '/cart'),
              onMenuTap: _placeholder,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'The Print Shack',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'The Print Shack lets you add personalised text to a range of '
                    'Union Shop products. Ideal for clubs, societies, teams and gifts.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'How it works',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '1. Choose a product and colour.\n'
                    '2. Pick your print position and number of lines.\n'
                    '3. Enter your personalised text.\n'
                    '4. Review your summary and place the order in the cart.\n\n'
                    'All examples in this coursework are for demonstration only – '
                    'no real orders are processed.',
                    style: TextStyle(fontSize: 15, height: 1.6),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Turnaround & limits (demo)',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• Up to 3 lines of text per print area.\n'
                    '• Maximum 20 characters per line.\n'
                    '• One print position per item in this demo.\n'
                    '• Turnaround time, colours and prices are placeholders only.',
                    style: TextStyle(fontSize: 15, height: 1.6),
                  ),
                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/personalisation');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4d2963),
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                      child: const Text(
                        'START PERSONALISING',
                        style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 14,
                        ),
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