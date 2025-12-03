// lib/services/cart_service.dart
import '../models/product.dart';
import '../models/cart_item.dart';

class CartService {
  CartService._internal();

  static final CartService instance = CartService._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  double get subtotal =>
      _items.fold(0.0, (sum, item) => sum + item.lineTotal);

  void addToCart({
    required Product product,
    required String colour,
    required String size,
    int quantity = 1,
  }) {
    // If same product + same options already exist, bump quantity
    final existingIndex = _items.indexWhere(
      (item) =>
          item.product.title == product.title &&
          item.colour == colour &&
          item.size == size,
    );

    if (existingIndex != -1) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(
        CartItem(
          product: product,
          colour: colour,
          size: size,
          quantity: quantity,
        ),
      );
    }
  }

  void updateQuantity(CartItem item, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(item);
      return;
    }

    final index = _items.indexOf(item);
    if (index != -1) {
      _items[index].quantity = newQuantity;
    }
  }

  void removeItem(CartItem item) {
    _items.remove(item);
  }

  void clear() {
    _items.clear();
  }
}
