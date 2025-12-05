import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/product_page.dart';
import 'package:union_shop/data/dummy_products.dart';

void main() {
  group('Product Page Tests', () {
    Widget createTestWidget() {
      return MaterialApp(
        routes: {
          '/': (context) => const ProductPage(),
          '/cart': (context) => const Scaffold(body: Text('Cart Page')),
          '/login': (context) => const Scaffold(body: Text('Login Page')),
        },
        home: const ProductPage(),
      );
    }

    testWidgets('should display product page with product details', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check that product information is displayed
      expect(find.text(dummyProducts.first.title), findsOneWidget);
      expect(find.text(dummyProducts.first.price), findsOneWidget);
    });

    testWidgets('should display colour and size dropdowns', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check that colour and size selectors are present
      if (dummyProducts.first.colours.isNotEmpty) {
        expect(find.text('Colour'), findsOneWidget);
      }
      if (dummyProducts.first.sizes.isNotEmpty) {
        expect(find.text('Size'), findsOneWidget);
      }
    });

    testWidgets('should display quantity selector', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check that quantity selector is present
      expect(find.text('Quantity'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
    });

    testWidgets('should display add to cart button', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check that add to cart button is present
      expect(find.text('ADD TO CART'), findsOneWidget);
    });

    testWidgets('should increment quantity when plus button tapped', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find and tap the plus button
      final plusButton = find.byIcon(Icons.add);
      await tester.tap(plusButton);
      await tester.pump();

      // Verify quantity increased
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('should not decrement quantity below 1', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find the minus button (should be disabled at quantity 1)
      final minusButton = find.byIcon(Icons.remove);
      
      // Try to tap it
      await tester.tap(minusButton);
      await tester.pump();

      // Quantity should still be 1
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should display back button', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check that back button is present
      expect(find.text('Back to collection'), findsOneWidget);
    });
  });
}
