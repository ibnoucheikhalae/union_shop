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
}
