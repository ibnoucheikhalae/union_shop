// lib/models/cart_item.dart
import 'product.dart';

class CartItem {
  final Product product;
  final String colour;
  final String size;
  int quantity;

  CartItem({
    required this.product,
    required this.colour,
    required this.size,
    this.quantity = 1,
  });

  // Parse "£6.99" -> 6.99
  double get unitPriceValue {
    final cleaned = product.price.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  double get lineTotal => unitPriceValue * quantity;

  // Serialization for persistence
  Map<String, dynamic> toJson() => {
        'productId': product.id,
        'productTitle': product.title,
        'productPrice': product.price,
        'productCollectionSlug': product.collectionSlug,
        'productImageUrl': product.imageUrl,
        'colour': colour,
        'size': size,
        'quantity': quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product(
        id: json['productId'] as String,
        title: json['productTitle'] as String,
        price: json['productPrice'] as String,
        collectionSlug: json['productCollectionSlug'] as String,
        imageUrl: json['productImageUrl'] as String?,
      ),
      colour: json['colour'] as String,
      size: json['size'] as String,
      quantity: json['quantity'] as int,
    );
  }
}
