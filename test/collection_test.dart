import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/data/dummy_products.dart';
import 'package:union_shop/data/dummy_collections.dart';

void main() {
  group('Collection Data Tests', () {
    test('should have 12 products in sportswear collection', () {
      final sportswearProducts = dummyProducts
          .where((p) => p.collectionSlug == 'sportswear')
          .toList();
      expect(sportswearProducts.length, 12);
      
      for (var product in sportswearProducts) {
        expect(product.collectionSlug, 'sportswear');
      }
    });

    test('should have 12 products in gifts collection', () {
      final giftsProducts = dummyProducts
          .where((p) => p.collectionSlug == 'gifts')
          .toList();
      expect(giftsProducts.length, 12);
    });

    test('should have 12 products in stationery collection', () {
      final stationeryProducts = dummyProducts
          .where((p) => p.collectionSlug == 'stationery')
          .toList();
      expect(stationeryProducts.length, 12);
    });

    test('should have 12 products in campus essentials collection', () {
      final essentialsProducts = dummyProducts
          .where((p) => p.collectionSlug == 'campus-essentials')
          .toList();
      expect(essentialsProducts.length, 12);
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
      for (var product in dummyProducts) {
        expect(product.imageUrl, isNotEmpty,
            reason: 'Product ${product.title} has empty imageUrl');
        final url = product.imageUrl ?? '';
        expect(url.startsWith('http') || url.startsWith('assets'), true,
            reason: 'Product ${product.title} has invalid URL: $url');
      }
    });

    test('all products should have valid prices', () {
      for (var product in dummyProducts) {
        expect(product.price, isNotEmpty);
        expect(product.price.contains('£'), true);
      }
    });
  });
}
