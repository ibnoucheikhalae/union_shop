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