// lib/services/cart_service.dart
import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartService {
  CartService._private();
  static final CartService instance = CartService._private();

  final ValueNotifier<List<CartItem>> items = ValueNotifier<List<CartItem>>([]);

  void addProduct(Product p) {
    final list = List<CartItem>.from(items.value);
    final idx = list.indexWhere((ci) => ci.product.id == p.id);
    if (idx >= 0) {
      list[idx].quantity += 1;
    } else {
      list.add(CartItem(product: p));
    }
    items.value = list;
  }

  void removeProduct(String productId) {
    final list = List<CartItem>.from(items.value)..removeWhere((ci) => ci.product.id == productId);
    items.value = list;
  }

  void setQuantity(String productId, int qty) {
    if (qty <= 0) {
      removeProduct(productId);
      return;
    }
    final list = List<CartItem>.from(items.value);
    final idx = list.indexWhere((ci) => ci.product.id == productId);
    if (idx >= 0) {
      list[idx].quantity = qty;
      items.value = list;
    }
  }

  double get total {
    return items.value.fold(0.0, (s, ci) => s + ci.totalPrice);
  }

  void clear() {
    items.value = [];
  }
}