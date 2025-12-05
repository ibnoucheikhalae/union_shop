import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/search_service.dart';
import 'package:union_shop/data/dummy_products.dart';

void main() {
  group('Search Service Tests', () {
    test('should return empty list for empty query', () {
      final results = SearchService.searchProducts('');
      expect(results.isEmpty, true);
    });

    test('should find products by title', () {
      final results = SearchService.searchProducts('hoodie');
      expect(results.isNotEmpty, true);
      // Verify at least one result has 'hoodie' in the title
      expect(
        results.any((p) => p.title.toLowerCase().contains('hoodie')),
        true,
      );
    });

    test('should find products by collection slug', () {
      final results = SearchService.searchProducts('sportswear');
      expect(results.isNotEmpty, true);
      for (var product in results) {
        expect(product.collectionSlug.contains('sportswear'), true);
      }
    });

    test('should be case insensitive', () {
      final resultsLower = SearchService.searchProducts('hoodie');
      final resultsUpper = SearchService.searchProducts('HOODIE');
      final resultsMixed = SearchService.searchProducts('Hoodie');
      
      expect(resultsLower.length, resultsUpper.length);
      expect(resultsLower.length, resultsMixed.length);
    });

    test('should find products by colour', () {
      // Find products that have colours
      final allProducts = dummyProducts.where(
        (p) => p.colours.isNotEmpty,
      ).toList();
      
      if (allProducts.isNotEmpty) {
        final colour = allProducts.first.colours.first;
        final results = SearchService.searchProducts(colour.toLowerCase());
        expect(results.isNotEmpty, true);
      }
    });

    test('should find products by size', () {
      // Find products that have sizes
      final allProducts = dummyProducts.where(
        (p) => p.sizes.isNotEmpty,
      ).toList();
      
      if (allProducts.isNotEmpty) {
        final size = allProducts.first.sizes.first;
        final results = SearchService.searchProducts(size.toLowerCase());
        expect(results.isNotEmpty, true);
      }
    });

    test('should return no results for non-existent query', () {
      final results = SearchService.searchProducts('xyznonexistent123');
      expect(results.isEmpty, true);
    });

    test('should search in product descriptions', () {
      // Find a product with a description
      final productWithDesc = dummyProducts.firstWhere(
        (p) => p.description != null && p.description!.isNotEmpty,
        orElse: () => dummyProducts.first,
      );
      
      if (productWithDesc.description != null) {
        // Take a word from the description
        final words = productWithDesc.description!.split(' ');
        if (words.isNotEmpty) {
          final results = SearchService.searchProducts(words.first.toLowerCase());
          expect(results.isNotEmpty, true);
        }
      }
    });
  });
}
