// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/home_page.dart';
import 'pages/product_page.dart';
import 'pages/about_page.dart';
import 'pages/collections_page.dart';
import 'pages/collection_view_page.dart';
import 'pages/sale_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/cart_page.dart';
import 'pages/checkout_page.dart';
import 'pages/printshack_about_page.dart';
import 'pages/personalisation_page.dart';
import 'pages/search_page.dart';
import 'pages/account_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDcHkbOsG0nWQr-iCh1qx5mvhWkjVr0W6c',
        appId: '1:450513610026:web:83ed47b63dfdf2b879aa53',
        messagingSenderId: '450513610026',
        projectId: 'union-shop-a',
        storageBucket: 'union-shop-a.firebasestorage.app',
      ),
    );
  } catch (e) {
    // Firebase initialization error - continue without Firebase
    debugPrint('Firebase initialization failed: $e');
  }
  
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
        '/checkout': (context) => const CheckoutPage(),
        '/printshack': (context) => const PrintShackAboutPage(),
        '/personalisation': (context) => const PersonalisationPage(),
        '/search': (context) => const SearchPage(),
        '/account': (context) => const AccountPage(),
      },
    );
  }
}
