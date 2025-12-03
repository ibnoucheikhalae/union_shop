// lib/models/collection.dart
class Collection {
  final String id;
  final String slug;        // e.g. 'hoodies', 'gifts'
  final String title;
  final String description;
  final String category;    // e.g. 'clothing', 'gifts', 'stationery'

  const Collection({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.category,
  });
}
