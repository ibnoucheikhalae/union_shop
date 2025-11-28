import 'package:flutter/material.dart';
import '../widgets/app_header.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppHeader(Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const Text(
      'Collections',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    const SizedBox(height: 16),

    ListTile(
      title: const Text('Hoodies & Sweatshirts'),
      subtitle: const Text('Warm and comfy uni hoodies'),
      onTap: () {
        Navigator.pushNamed(context, '/collection');
      },
    ),
        ListTile(
      title: const Text('Hoodies & Sweatshirts'),
      subtitle: const Text('Warm and comfy uni hoodies'),
      onTap: () {
        Navigator.pushNamed(context, '/collection');
      },
    ),
    const Divider(),
    const ListTile(
      title: Text('Gifts & Accessories'),
      subtitle: Text('Mugs, magnets, keyrings and more'),
    ),
    const Divider(),
    const ListTile(
      title: Text('Stationery'),
      subtitle: Text('Notebooks, pens, and study essentials'),
    ),

  ],
),

              ),
            ),
              onLogoTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
              onSearchTap: () {},
              onAccountTap: () {},
              onCartTap: () {},
              onMenuTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
