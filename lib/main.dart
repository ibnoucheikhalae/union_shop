// lib/main.dart
import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/product_page.dart';
import 'pages/about_page.dart';
import 'pages/collections_page.dart';
import 'pages/collection_view_page.dart';
import 'pages/sale_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/cart_page.dart';
import 'pages/printshack_about_page.dart';
import 'pages/personalisation_page.dart';


void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/product': (context) => const ProductPage(),
        '/about': (context) => const AboutPage(),
        '/collections': (context) => const CollectionsPage(),
        '/collection': (context) => const CollectionViewPage(),
        '/sale': (context) => const SalePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/cart': (context) => const CartPage(),
         '/printshack': (context) => const PrintShackAboutPage(),
    '/personalisation': (context) => const PersonalisationPage(),
      },
    );
  }
}
