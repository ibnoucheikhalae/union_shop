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

  /// Creates a copy of this collection with optional replacement fields.
  Collection copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
    String? slug,
  }) {
    return Collection(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      slug: slug ?? this.slug,
    );
  }

  /// Convert from a JSON-like map (from API or local storage).
  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
    );
  }

  /// Convert to a JSON-like map suitable for serialization.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'slug': slug,
    };
  }

  @override
  String toString() {
    return 'Collection(id: $id, title: $title, slug: $slug)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Collection &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.image == image &&
        other.slug == slug;
  }

  @override
  int get hashCode => Object.hash(id, title, description, image, slug);
}
