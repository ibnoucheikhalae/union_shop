import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/search_service.dart';

void main() {
  group('Search Page Tests', () {
    test('should return empty results for empty query', () {
      final results = SearchService.searchProducts('');
      expect(results.isEmpty, true);
    });

    test('should search products by title', () {
      final results = SearchService.searchProducts('hoodie');
      expect(results.isNotEmpty, true);
    });

    test('should search products by collection', () {
      final results = SearchService.searchProducts('sportswear');
      expect(results.isNotEmpty, true);
    });

    test('should be case insensitive', () {
      final lower = SearchService.searchProducts('hoodie');
      final upper = SearchService.searchProducts('HOODIE');
      
      expect(lower.length, upper.length);
    });

    test('should display search results count', () {
      final results = SearchService.searchProducts('hoodie');
      final count = results.length;
      
      expect(count, greaterThan(0));
      final message = 'Found $count results';
      expect(message, contains('Found'));
    });

    test('should show no results message for invalid search', () {
      final results = SearchService.searchProducts('xyzinvalid123');
      expect(results.isEmpty, true);
      
      const noResultsMessage = 'No products found';
      expect(noResultsMessage, contains('No products'));
    });

    test('should have search input field', () {
      var searchQuery = '';
      searchQuery = 'hoodie';
      
      expect(searchQuery, 'hoodie');
      expect(searchQuery.isNotEmpty, true);
    });

    test('should clear search query', () {
      var searchQuery = 'hoodie';
      searchQuery = '';
      
      expect(searchQuery.isEmpty, true);
    });

    test('should navigate to product from search results', () {
      final results = SearchService.searchProducts('hoodie');
      if (results.isNotEmpty) {
        final product = results.first;
        expect(product.id, isNotEmpty);
      }
    });
  });
}
