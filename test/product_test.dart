import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/data/dummy_products.dart';

void main() {
  group('Product Model Tests', () {
    test('should create product with required fields', () {
      const product = Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      expect(product.id, 'test1');
      expect(product.title, 'Test Product');
      expect(product.price, '£10.00');
      expect(product.collectionSlug, 'test');
      expect(product.imageUrl, 'https://via.placeholder.com/200');
    });

    test('should create product with optional fields', () {
      const product = Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
        description: 'Test description',
        colours: ['Black', 'White'],
        sizes: ['S', 'M', 'L'],
      );

      expect(product.description, 'Test description');
      expect(product.colours, ['Black', 'White']);
      expect(product.sizes, ['S', 'M', 'L']);
    });

    test('dummy products should have valid data', () {
      expect(dummyProducts.isNotEmpty, true);

      for (var product in dummyProducts) {
        expect(product.id, isNotEmpty);
        expect(product.title, isNotEmpty);
        expect(product.price, isNotEmpty);
        expect(product.collectionSlug, isNotEmpty);
      }
    });

    test('should have products with colours and sizes', () {
      final productsWithColours = dummyProducts.where(
        (p) => p.colours.isNotEmpty,
      ).toList();
      expect(productsWithColours.isNotEmpty, true);

      final productsWithSizes = dummyProducts.where(
        (p) => p.sizes.isNotEmpty,
      ).toList();
      expect(productsWithSizes.isNotEmpty, true);
    });

    test('should have products with descriptions', () {
      final productsWithDescriptions = dummyProducts.where(
        (p) => p.description != null && p.description!.isNotEmpty,
      ).toList();
      expect(productsWithDescriptions.isNotEmpty, true);
    });

    test('products should belong to valid collections', () {
      final collections = <String>{};
      for (var product in dummyProducts) {
        collections.add(product.collectionSlug);
      }

      expect(collections.contains('hoodies'), true);
      expect(collections.contains('sportswear'), true);
      expect(collections.contains('gifts'), true);
      expect(collections.contains('stationery'), true);
      expect(collections.contains('campus-essentials'), true);
    });
  });
}
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
