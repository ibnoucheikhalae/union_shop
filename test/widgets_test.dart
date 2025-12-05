import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/product_card.dart';
import 'package:union_shop/widgets/app_header.dart';

void main() {
  group('Product Card Widget Tests', () {
    Widget createTestWidget(Widget child) {
      return MaterialApp(
        home: Scaffold(
          body: child,
        ),
      );
    }

    testWidgets('should display product information', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          const ProductCard(
            id: 'test1',
            collectionSlug: 'test',
            title: 'Test Product',
            price: '£10.00',
            imageUrl: 'https://via.placeholder.com/200',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('£10.00'), findsOneWidget);
    });

    testWidgets('should display add to cart button', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          const ProductCard(
            id: 'test1',
            collectionSlug: 'test',
            title: 'Test Product',
            price: '£10.00',
            imageUrl: 'https://via.placeholder.com/200',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.add_shopping_cart), findsOneWidget);
    });

    testWidgets('should be tappable', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/product': (context) => const Scaffold(body: Text('Product Page')),
          },
          home: Scaffold(
            body: const ProductCard(
              id: 'test1',
              collectionSlug: 'test',
              title: 'Test Product',
              price: '£10.00',
              imageUrl: 'https://via.placeholder.com/200',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap on the product card
      await tester.tap(find.byType(ProductCard));
      await tester.pumpAndSettle();

      // Should navigate to product page
      expect(find.text('Product Page'), findsOneWidget);
    });
  });

  group('App Header Widget Tests', () {
    testWidgets('should display header with icons', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppHeader(
              onLogoTap: () {},
              onSearchTap: () {},
              onAccountTap: () {},
              onCartTap: () {},
              onMenuTap: () {},
            ),
          ),
        ),
      );
      await tester.pump();

      // Check that icons are present
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
    });

    testWidgets('should call callbacks when icons tapped', (tester) async {
      bool searchTapped = false;
      bool cartTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppHeader(
              onLogoTap: () {},
              onSearchTap: () {
                searchTapped = true;
              },
              onAccountTap: () {},
              onCartTap: () {
                cartTapped = true;
              },
              onMenuTap: () {},
            ),
          ),
        ),
      );
      await tester.pump();

      // Tap search icon
      await tester.tap(find.byIcon(Icons.search));
      expect(searchTapped, true);

      // Tap cart icon
      await tester.tap(find.byIcon(Icons.shopping_cart_outlined));
      expect(cartTapped, true);
    });
  });
}
