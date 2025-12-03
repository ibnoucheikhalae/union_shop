// lib/models/product.dart
class Product {
  final String id;
  final String title;
  final String price;
  final String collectionSlug; // links to a collection

  // Optional fields used by various UI screens
  final String? imageUrl;
  final String? description;
  final List<String> sizes;
  final List<String> colours;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.collectionSlug,
    this.imageUrl,
    this.description,
    this.sizes = const [],
    this.colours = const [],
  });
}
