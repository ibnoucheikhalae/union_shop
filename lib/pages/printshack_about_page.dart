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