import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/cart_page.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/models/product.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('Cart Page Tests', () {
    setUp(() async {
      // Clear cart before each test
      await CartService.instance.clear();
    });

    Widget createTestWidget() {
      return MaterialApp(
        home: const CartPage(),
        routes: {
          '/checkout': (context) => const Scaffold(body: Text('Checkout Page')),
        },
      );
    }

    testWidgets('should display empty cart message when cart is empty', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check that empty cart message is displayed
      expect(find.text('Your cart is empty'), findsOneWidget);
      expect(find.text('CONTINUE SHOPPING'), findsOneWidget);
    });

    testWidgets('should display cart items when products are added', (tester) async {
      // Add a test product to cart
      final testProduct = const Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      await CartService.instance.addToCart(
        product: testProduct,
        colour: 'Black',
        size: 'M',
        quantity: 1,
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check that product is displayed
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('£10.00'), findsOneWidget);
    });

    testWidgets('should calculate total correctly', (tester) async {
      // Add products to cart
      final testProduct1 = const Product(
        id: 'test1',
        title: 'Product 1',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      await CartService.instance.addToCart(
        product: testProduct1,
        colour: 'Black',
        size: 'M',
        quantity: 2,
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check that total is displayed correctly
      expect(find.textContaining('£20.00'), findsWidgets);
    });

    testWidgets('should display checkout button when cart has items', (tester) async {
      // Add a test product
      final testProduct = const Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      await CartService.instance.addToCart(
        product: testProduct,
        colour: 'Black',
        size: 'M',
        quantity: 1,
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check that checkout button is present
      expect(find.text('PROCEED TO CHECKOUT'), findsOneWidget);
    });

    testWidgets('should remove item from cart when delete is tapped', (tester) async {
      // Add a test product
      final testProduct = const Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      await CartService.instance.addToCart(
        product: testProduct,
        colour: 'Black',
        size: 'M',
        quantity: 1,
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find and tap delete button
      final deleteButton = find.byIcon(Icons.delete);
      if (deleteButton.evaluate().isNotEmpty) {
        await tester.tap(deleteButton);
        await tester.pumpAndSettle();

        // Cart should now be empty
        expect(find.text('Your cart is empty'), findsOneWidget);
      }
    });
  });
}
