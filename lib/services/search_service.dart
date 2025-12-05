// lib/services/search_service.dart
import '../models/product.dart';
import '../data/dummy_products.dart';

class SearchService {
  static List<Product> searchProducts(String query) {
    if (query.isEmpty) {
      return [];
    }

    final lowerQuery = query.toLowerCase();

    return dummyProducts.where((product) {
      final title = product.title.toLowerCase();
      final description = product.description?.toLowerCase() ?? '';
      final collectionSlug = product.collectionSlug.toLowerCase();
      
      // Check if any word in title matches the query
      if (_matchesWord(title, lowerQuery)) {
        return true;
      }

      // Check if any word in description matches the query
      if (_matchesWord(description, lowerQuery)) {
        return true;
      }

      // Check if collection slug matches
      if (_matchesWord(collectionSlug, lowerQuery)) {
        return true;
      }

      // Search in price
      if (product.price.toLowerCase().contains(lowerQuery)) {
        return true;
      }

      // Search in sizes
      if (product.sizes.any((size) => size.toLowerCase().contains(lowerQuery))) {
        return true;
      }

      // Search in colours
      if (product.colours.any((colour) => colour.toLowerCase().contains(lowerQuery))) {
        return true;
      }

      return false;
    }).toList();
  }

  // Helper method to check if query matches as a whole word or at word boundaries
  static bool _matchesWord(String text, String query) {
    // Split text into words (by spaces, hyphens, etc.)
    final words = text.split(RegExp(r'[\s\-_]+'));
    
    // Check if any word starts with the query or equals it
    for (final word in words) {
      if (word == query || word.startsWith(query)) {
        return true;
      }
    }
    
    // Also check if the full text contains the query as a standalone word
    final pattern = RegExp(r'\b' + RegExp.escape(query) + r'\b');
    return pattern.hasMatch(text);
  }
}
