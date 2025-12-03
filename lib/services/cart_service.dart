// lib/services/cart_service.dart
import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartService {
  CartService._private();
  static final CartService instance = CartService._private();

  

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
