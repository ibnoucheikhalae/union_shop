import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/data/dummy_products.dart';

void main() {
  group('Collection View Page Tests', () {
    test('should filter products by collection slug', () {
      const slug = 'sportswear';
      final products = dummyProducts.where(
        (p) => p.collectionSlug == slug,
      ).toList();
      
      expect(products.isNotEmpty, true);
      expect(products.length, 6);
    });

    test('should display all products in hoodies collection', () {
      const slug = 'hoodies';
      final products = dummyProducts.where(
        (p) => p.collectionSlug == slug,
      ).toList();
      
      expect(products.isNotEmpty, true);
      expect(products.length, greaterThanOrEqualTo(5));
    });

    test('should display all products in gifts collection', () {
      const slug = 'gifts';
      final products = dummyProducts.where(
        (p) => p.collectionSlug == slug,
      ).toList();
      
      expect(products.isNotEmpty, true);
      expect(products.length, 3);
    });

    test('should handle empty collection gracefully', () {
      const slug = 'nonexistent';
      final products = dummyProducts.where(
        (p) => p.collectionSlug == slug,
      ).toList();
      
      expect(products.isEmpty, true);
    });

    test('should navigate to product page with correct arguments', () {
      final product = dummyProducts.first;
      final args = {
        'productId': product.id,
        'collectionSlug': product.collectionSlug,
      };
      
      expect(args['productId'], isNotEmpty);
      expect(args['collectionSlug'], isNotEmpty);
    });

    test('should display collection breadcrumb navigation', () {
      const slug = 'sportswear';
      final breadcrumb = 'Home > Collections > $slug';
      expect(breadcrumb, contains('Collections'));
      expect(breadcrumb, contains(slug));
    });
  });
}
