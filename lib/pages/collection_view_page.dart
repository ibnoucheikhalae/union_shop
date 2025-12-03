import 'package:flutter/material.dart';
import '../widgets/app_header.dart';

class CollectionViewPage extends StatelessWidget {
  const CollectionViewPage({super.key});

  void _placeholder() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
            onCartTap: _placeholder,
            onMenuTap: _placeholder,
        Padding(
  padding: const EdgeInsets.all(24.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Text(
        'Hoodies & Sweatshirts',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 8),
      Text(
        'Warm and comfy uni hoodies for everyday campus life.',
        style: TextStyle(
          fontSize: 14,
          height: 1.5,
        ),
      ),
    ],
  ),
),
      ),
    );
  }
}

