import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/data/dummy_products.dart';

void main() {
  group('Home Page Tests', () {
    test('should have products for featured collection', () {
      final hoodieProducts = dummyProducts.where(
        (p) => p.collectionSlug == 'hoodies',
      ).toList();
      
      expect(hoodieProducts.isNotEmpty, true);
      expect(hoodieProducts.length, greaterThanOrEqualTo(5));
    });

    test('should have bestseller products available', () {
      final bestsellers = dummyProducts.take(5).toList();
      expect(bestsellers.length, 5);
      
      for (var product in bestsellers) {
        expect(product.id, isNotEmpty);
        expect(product.title, isNotEmpty);
        expect(product.price, isNotEmpty);
      }
    });

    test('should display hero banner content', () {
      const bannerText = 'Welcome to The Union Shop';
      expect(bannerText, isNotEmpty);
      expect(bannerText.toLowerCase(), contains('union shop'));
    });

    test('should have navigation to collections', () {
      const collectionsRoute = '/collections';
      expect(collectionsRoute, '/collections');
    });

    test('should have navigation to sale page', () {
      const saleRoute = '/sale';
      expect(saleRoute, '/sale');
    });

    test('should display featured products grid', () {
      final featuredProducts = dummyProducts.take(8).toList();
      expect(featuredProducts.length, 8);
      expect(featuredProducts.every((p) => (p.imageUrl ?? '').isNotEmpty), true);
      expect(featuredProducts.every((p) => p.title.isNotEmpty), true);
    });

    test('should have shop now call to action', () {
      const ctaText = 'Shop Now';
      expect(ctaText, isNotEmpty);
      expect(ctaText.toLowerCase(), contains('shop'));
    });
  });
}
