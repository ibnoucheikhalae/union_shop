// lib/pages/cart_page.dart
import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/footer.dart';
class CartPage extends StatelessWidget {
  const CartPage({super.key});

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