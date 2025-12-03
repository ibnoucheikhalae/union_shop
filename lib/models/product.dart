// lib/models/product.dart
class Product {
  final String id;
  final String title;
  final String price;
  final String collectionSlug; // links to a collection

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.collectionSlug,
  });
}
