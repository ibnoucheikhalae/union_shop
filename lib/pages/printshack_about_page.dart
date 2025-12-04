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
                  // Centered title
                  const Center(
                    child: Text(
                      'The Union Print Shack',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Placeholder rectangular image
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.image,
                        size: 48,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Make It Your Own with The Union Print Shack',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Want something a bit more you? We offer fast, affordable custom text prints on hoodies and tees. '
                    'Just pop into the shop — we\'re always happy to help you choose colours, styles, and layouts.',
                    style: TextStyle(fontSize: 15, height: 1.6),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Bring Your Own or Choose Ours',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Whether it\'s official Uni merch or your favourite hoodie from home, we can personalise it with heat-pressed text or logos.',
                    style: TextStyle(fontSize: 15, height: 1.6),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Simple Prices Students Love',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '• £3 — one line of text or a small chest print\n'
                    '• £5 — two lines of text or a large back print\n\n'
                    'Orders are usually ready in three working days, and we\'ll contact you as soon as it\'s done.',
                    style: TextStyle(fontSize: 15, height: 1.6),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Before You Order',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'We print text exactly as you write it. Double-check spelling, punctuation, and capital letters, as personalised items are non-refundable.',
                    style: TextStyle(fontSize: 15, height: 1.6),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Let\'s Get Creating',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Come see us at the Print Shack — your ideas, your gear, your style',
                    style: TextStyle(fontSize: 15, height: 1.6),
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