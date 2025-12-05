import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/data/dummy_products.dart';
import 'package:union_shop/data/dummy_collections.dart';

void main() {
  group('Collection Data Tests', () {
    test('should have 6 products in sportswear collection', () {
      final sportswearProducts = dummyProducts['sportswear'] ?? [];
      expect(sportswearProducts.length, 6);
      
      for (var product in sportswearProducts) {
        expect(product.collectionSlug, 'sportswear');
      }
    });

    test('should have 3 products in gifts collection', () {
      final giftsProducts = dummyProducts['gifts'] ?? [];
      expect(giftsProducts.length, 3);
    });

    test('should have 3 products in stationery collection', () {
      final stationeryProducts = dummyProducts['stationery'] ?? [];
      expect(stationeryProducts.length, 3);
    });

    test('should have 3 products in campus essentials collection', () {
      final essentialsProducts = dummyProducts['campus-essentials'] ?? [];
      expect(essentialsProducts.length, 3);
    });

    test('all collections should have metadata', () {
      expect(dummyCollections.isNotEmpty, true);
      
      final sportswearCollection = dummyCollections.firstWhere(
        (c) => c.slug == 'sportswear',
      );
      expect(sportswearCollection.title, 'Sportswear');
      expect(sportswearCollection.description, isNotEmpty);
    });

    test('all products should have valid image URLs', () {
      dummyProducts.forEach((collection, products) {
        for (var product in products) {
          expect(product.imageUrl, isNotEmpty);
          expect(product.imageUrl.startsWith('http'), true,
              reason: 'Product ${product.title} in $collection has invalid URL');
        }
      });
    });

    test('all products should have valid prices', () {
      dummyProducts.forEach((collection, products) {
        for (var product in products) {
          expect(product.price, isNotEmpty);
          expect(product.price.contains('£'), true);
        }
      });
    });
  });
}
