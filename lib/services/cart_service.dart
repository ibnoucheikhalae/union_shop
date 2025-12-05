// lib/services/cart_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartService {
  CartService._internal();

  static final CartService instance = CartService._internal();

  final List<CartItem> _items = [];
  static const String _cartKey = 'shopping_cart';

  List<CartItem> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.fold(0.0, (sum, item) => sum + item.lineTotal);

  double get tax => subtotal * 0.20; // 20% VAT

  double get shipping => subtotal > 50 ? 0.0 : 4.99; // Free shipping over £50

  double get total => subtotal + tax + shipping;

  // Load cart from persistent storage
  Future<void> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString(_cartKey);

      if (cartJson != null) {
        final List<dynamic> decoded = json.decode(cartJson);
        _items.clear();
        _items.addAll(decoded.map((item) => CartItem.fromJson(item)));
      }
    } catch (e) {
      print('Error loading cart: $e');
    }
  }

  // Save cart to persistent storage
  Future<void> _saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = json.encode(_items.map((item) => item.toJson()).toList());
      await prefs.setString(_cartKey, cartJson);
    } catch (e) {
      print('Error saving cart: $e');
    }
  }

  Future<void> addToCart({
    required Product product,
    required String colour,
    required String size,
    int quantity = 1,
  }) async {
    // If same product + same options already exist, bump quantity
    final existingIndex = _items.indexWhere(
      (item) =>
          item.product.id == product.id &&
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

    await _saveCart();
  }

  Future<void> updateQuantity(CartItem item, int newQuantity) async {
    if (newQuantity <= 0) {
      await removeItem(item);
      return;
    }

    final index = _items.indexOf(item);
    if (index != -1) {
      _items[index].quantity = newQuantity;
      await _saveCart();
    }
  }

  Future<void> removeItem(CartItem item) async {
    _items.remove(item);
    await _saveCart();
  }

  Future<void> clear() async {
    _items.clear();
    await _saveCart();
  }
}
