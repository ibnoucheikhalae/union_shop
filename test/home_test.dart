import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/data/dummy_products.dart';

void main() {
  group('Home Page Data Tests', () {
    test('dummy products should be properly defined', () {
      // Test that dummy products are valid
      expect(dummyProducts.isNotEmpty, true);
      
      final hoodieProducts = dummyProducts.where((p) => p.collectionSlug == 'hoodies').toList();
      expect(hoodieProducts.isNotEmpty, true);
      
      final hoodie = hoodieProducts.first;
      expect(hoodie.id, isNotEmpty);
      expect(hoodie.title, isNotEmpty);
      expect(hoodie.price, isNotEmpty);
    });

    test('should have products in all collections', () {
      // Check that all major collections have products
      final hoodiesProducts = dummyProducts.where((p) => p.collectionSlug == 'hoodies').toList();
      final sportswearProducts = dummyProducts.where((p) => p.collectionSlug == 'sportswear').toList();
      final giftsProducts = dummyProducts.where((p) => p.collectionSlug == 'gifts').toList();
      final stationeryProducts = dummyProducts.where((p) => p.collectionSlug == 'stationery').toList();
      final essentialsProducts = dummyProducts.where((p) => p.collectionSlug == 'campus-essentials').toList();
      
      expect(hoodiesProducts.isNotEmpty, true);
      expect(sportswearProducts.isNotEmpty, true);
      expect(giftsProducts.isNotEmpty, true);
      expect(stationeryProducts.isNotEmpty, true);
      expect(essentialsProducts.isNotEmpty, true);
    });

    test('products should have valid image URLs', () {
      for (var product in dummyProducts) {
        final url = product.imageUrl ?? '';
        expect(url, isNotEmpty);
        expect(url.startsWith('http') || url.startsWith('assets'), true,
            reason: 'Product ${product.title} has invalid URL: $url');
      }
    });

    test('products should have valid prices', () {
      for (var product in dummyProducts) {
        expect(product.price, isNotEmpty);
        expect(product.price.contains('£'), true);
      }
    });
  });
}
