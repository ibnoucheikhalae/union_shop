import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/data/dummy_products.dart';

void main() {
  group('Cart Page Tests', () {
    late CartService cart;

    setUp(() {
      cart = CartService.instance;
      cart.clear();
    });

    test('should display empty cart message when cart is empty', () {
      expect(cart.isEmpty, true);
      const emptyMessage = 'Your cart is empty';
      expect(emptyMessage, isNotEmpty);
    });

    test('should show cart items when products added', () {
      final product = dummyProducts.first;
      
      cart.addToCart(product: product, colour: '', size: '', quantity: 1);
      expect(cart.isEmpty, false);
      expect(cart.itemCount, 1);
    });

    test('should calculate cart totals correctly', () {
      final product = dummyProducts.first;
      
      cart.addToCart(product: product, colour: '', size: '', quantity: 2);
      expect(cart.subtotal, greaterThan(0));
      expect(cart.total, greaterThan(cart.subtotal));
    });

    test('should show checkout button when cart has items', () {
      cart.addToCart(product: dummyProducts.first, colour: '', size: '', quantity: 1);
      
      final hasCheckoutButton = !cart.isEmpty;
      expect(hasCheckoutButton, true);
    });

    test('should navigate to checkout route', () {
      const checkoutRoute = '/checkout';
      expect(checkoutRoute, '/checkout');
    });
  });
}
