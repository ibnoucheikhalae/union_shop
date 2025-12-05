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
      // Search in title
      if (product.title.toLowerCase().contains(lowerQuery)) {
        return true;
      }

      // Search in description
      if (product.description != null &&
          product.description!.toLowerCase().contains(lowerQuery)) {
        return true;
      }

      // Search in collection slug
      if (product.collectionSlug.toLowerCase().contains(lowerQuery)) {
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
}
