// lib/models/collection.dart
class Collection {
  final String id;
  final String slug;        // e.g. 'hoodies', 'gifts'
  final String title;
  final String description;
  final String category;   
  // Optional image for the collection (asset path or remote URL)
  final String? imageUrl; // e.g. 'assets/images/hoodies.png' or remote URL

  const Collection({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.category,
    this.imageUrl,
  });
}
