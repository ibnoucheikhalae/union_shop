import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/search_service.dart';
import 'package:union_shop/data/dummy_products.dart';

void main() {
  group('Search Service Edge Case Tests', () {
    test('should handle very long search queries', () {
      final longQuery = 'a' * 1000;
      final results = SearchService.searchProducts(longQuery);
      
      // Should not crash and return empty or valid results
      expect(results, isA<List>());
    });

    test('should handle special characters in search', () {
      final specialQueries = [
        '!@#\$%^&*()',
        '___---===',
        '[]{}()<>',
        '\\n\\t\\r',
      ];

      for (var query in specialQueries) {
        final results = SearchService.searchProducts(query);
        expect(results, isA<List>());
      }
    });

    test('should handle unicode characters', () {
      final unicodeQueries = [
        '🔥',
        'café',
        '日本語',
        'Ñoño',
      ];

      for (var query in unicodeQueries) {
        final results = SearchService.searchProducts(query);
        expect(results, isA<List>());
      }
    });

    test('should handle search with only spaces', () {
      final results = SearchService.searchProducts('   ');
      expect(results.isEmpty, true);
    });

    test('should handle search with numbers', () {
      final results = SearchService.searchProducts('123');
      expect(results, isA<List>());
    });

    test('should handle partial word matches', () {
      final results = SearchService.searchProducts('hoo');
      expect(results, isA<List>());
      
      if (results.isNotEmpty) {
        expect(
          results.any((p) => 
            p.title.toLowerCase().contains('hoo') ||
            p.collectionSlug.toLowerCase().contains('hoo')
          ),
          true,
        );
      }
    });

    test('should be case insensitive for mixed case', () {
      final lower = SearchService.searchProducts('hoodie');
      final upper = SearchService.searchProducts('HOODIE');
      final mixed = SearchService.searchProducts('HoOdIe');
      final camel = SearchService.searchProducts('Hoodie');

      expect(lower.length, upper.length);
      expect(lower.length, mixed.length);
      expect(lower.length, camel.length);
    });

    test('should handle single character search', () {
      final results = SearchService.searchProducts('h');
      expect(results, isA<List>());
    });

    test('should handle search with leading/trailing spaces', () {
      final withSpaces = SearchService.searchProducts('  hoodie  ');
      final withoutSpaces = SearchService.searchProducts('hoodie');
      
      // Results should be similar (empty query returns empty results)
      expect(withSpaces, isA<List>());
      expect(withoutSpaces, isA<List>());
    });

    test('should handle multiple search terms', () {
      final results = SearchService.searchProducts('university hoodie');
      expect(results, isA<List>());
    });

    test('should find products by price format', () {
      final results = SearchService.searchProducts('£');
      
      // Should find products since prices contain £
      expect(results.isNotEmpty, true);
    });

    test('should handle repeated searches', () {
      final query = 'hoodie';
      
      final results1 = SearchService.searchProducts(query);
      final results2 = SearchService.searchProducts(query);
      final results3 = SearchService.searchProducts(query);

      expect(results1.length, results2.length);
      expect(results2.length, results3.length);
    });

    test('should handle alternating empty and non-empty queries', () {
      var results = SearchService.searchProducts('');
      expect(results.isEmpty, true);
      
      results = SearchService.searchProducts('hoodie');
      expect(results, isA<List>());
      
      results = SearchService.searchProducts('');
      expect(results.isEmpty, true);
      
      results = SearchService.searchProducts('sportswear');
      expect(results, isA<List>());
    });

    test('should return consistent results for same query', () {
      const query = 'hoodie';
      
      final results1 = SearchService.searchProducts(query);
      final results2 = SearchService.searchProducts(query);

      expect(results1.length, results2.length);
      
      for (int i = 0; i < results1.length; i++) {
        expect(results1[i].id, results2[i].id);
      }
    });

    test('should handle hyphenated search terms', () {
      final results = SearchService.searchProducts('campus-essentials');
      
      if (dummyProducts.any((p) => p.collectionSlug == 'campus-essentials')) {
        expect(results.isNotEmpty, true);
      }
    });

    test('should handle underscore in search', () {
      final results = SearchService.searchProducts('test_product');
      expect(results, isA<List>());
    });
  });
}
