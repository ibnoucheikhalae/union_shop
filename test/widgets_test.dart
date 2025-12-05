import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/product_card.dart';
import 'package:union_shop/widgets/collection_card.dart';
import 'package:union_shop/models/collection.dart';

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

    testWidgets('should create widget with all required properties', (tester) async {
      const productCard = ProductCard(
        id: 'test1',
        collectionSlug: 'sportswear',
        title: 'Hoodie',
        price: '£25.00',
        imageUrl: 'https://via.placeholder.com/200',
      );

      await tester.pumpWidget(createTestWidget(productCard));
      await tester.pumpAndSettle();

      // Verify the widget renders without errors
      expect(find.byType(ProductCard), findsOneWidget);
      expect(find.text('Hoodie'), findsOneWidget);
      expect(find.text('£25.00'), findsOneWidget);
    });

    testWidgets('should display multiple product cards', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: const [
                  ProductCard(
                    id: 'test1',
                    collectionSlug: 'test',
                    title: 'Product 1',
                    price: '£10.00',
                    imageUrl: 'https://via.placeholder.com/200',
                  ),
                  ProductCard(
                    id: 'test2',
                    collectionSlug: 'test',
                    title: 'Product 2',
                    price: '£15.00',
                    imageUrl: 'https://via.placeholder.com/200',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify both cards are present
      expect(find.byType(ProductCard), findsNWidgets(2));
      expect(find.text('Product 1'), findsOneWidget);
      expect(find.text('£10.00'), findsOneWidget);
    });
  });

  group('Collection Card Widget Tests', () {
    Widget createTestWidget(Widget child) {
      return MaterialApp(
        home: Scaffold(
          body: child,
        ),
      );
    }

    testWidgets('should display collection information', (tester) async {
      bool tapped = false;
      const collection = Collection(
        name: 'Sportswear',
        slug: 'sportswear',
        imageUrl: 'https://via.placeholder.com/300',
      );

      await tester.pumpWidget(
        createTestWidget(
          CollectionCard(
            collection: collection,
            onTap: () {
              tapped = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Sportswear'), findsOneWidget);
    });

    testWidgets('should call onTap when tapped', (tester) async {
      bool tapped = false;
      const collection = Collection(
        name: 'Test Collection',
        slug: 'test',
      );

      await tester.pumpWidget(
        createTestWidget(
          CollectionCard(
            collection: collection,
            onTap: () {
              tapped = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CollectionCard));
      expect(tapped, true);
    });

    testWidgets('should create collection card with all fields', (tester) async {
      const collection = Collection(
        name: 'Campus Essentials',
        slug: 'campus-essentials',
        imageUrl: 'https://via.placeholder.com/300',
        description: 'Essential items for campus life',
      );

      await tester.pumpWidget(
        createTestWidget(
          CollectionCard(
            collection: collection,
            onTap: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CollectionCard), findsOneWidget);
      expect(find.text('Campus Essentials'), findsOneWidget);
    });
  });
}
