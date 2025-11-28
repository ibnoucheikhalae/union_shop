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
            AppHeader(
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
