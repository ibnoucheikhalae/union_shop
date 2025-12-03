/// lib/models/collection.dart

class Collection {
  /// Unique identifier for this collection. Using `String` keeps it flexible
  /// for API responses that may use numeric or UUID values.
  final String id;


  final String title;

  /// Short description used in lists or overview pages.
  final String description;

  /// Image URL or local asset path for the collection.
  final String image;


  final String slug;

  /// Const constructor so instances can be const where helpful in tests
  /// and sample data.
  const Collection({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.slug,
  });
