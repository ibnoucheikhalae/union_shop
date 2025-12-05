import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/data/dummy_products.dart';

void main() {
  group('Cart Service Edge Case Tests', () {
    late CartService cart;

    setUp(() {
      cart = CartService.instance;
      cart.clear();
    });

    test('should handle adding product with empty colour and size', () {
      final product = dummyProducts.first;
      
      cart.addToCart(
        product: product,
        colour: '',
        size: '',
        quantity: 1,
      );

      expect(cart.isEmpty, false);
      expect(cart.itemCount, 1);
    });

    test('should handle adding same product with different colours', () {
      final product = dummyProducts.first;
      
      cart.addToCart(product: product, colour: 'Red', size: 'M', quantity: 1);
      cart.addToCart(product: product, colour: 'Blue', size: 'M', quantity: 1);

      expect(cart.itemCount, 2);
      expect(cart.items.length, 2);
    });

    test('should handle adding same product with different sizes', () {
      final product = dummyProducts.first;
      
      cart.addToCart(product: product, colour: 'Red', size: 'S', quantity: 1);
      cart.addToCart(product: product, colour: 'Red', size: 'L', quantity: 1);

      expect(cart.itemCount, 2);
      expect(cart.items.length, 2);
    });

    test('should merge same product with same options', () {
      final product = dummyProducts.first;
      
      cart.addToCart(product: product, colour: 'Red', size: 'M', quantity: 1);
      cart.addToCart(product: product, colour: 'Red', size: 'M', quantity: 2);

      expect(cart.itemCount, 3);
      expect(cart.items.length, 1);
    });

    test('should handle large quantity', () {
      final product = dummyProducts.first;
      
      cart.addToCart(
        product: product,
        colour: 'Black',
        size: 'L',
        quantity: 100,
      );

      expect(cart.itemCount, 100);
    });

    test('should handle multiple products with large quantities', () {
      final products = dummyProducts.take(3).toList();
      
      for (var product in products) {
        cart.addToCart(
          product: product,
          colour: 'Black',
          size: 'M',
          quantity: 50,
        );
      }

      expect(cart.itemCount, 150);
      expect(cart.items.length, 3);
    });

    test('should calculate tax correctly for various amounts', () {
      final product = dummyProducts.first;
      
      // Test small amount
      cart.clear();
      cart.addToCart(product: product, colour: '', size: '', quantity: 1);
      final smallTax = cart.tax;
      expect(smallTax, closeTo(cart.subtotal * 0.20, 0.01));

      // Test larger amount
      cart.clear();
      cart.addToCart(product: product, colour: '', size: '', quantity: 10);
      final largeTax = cart.tax;
      expect(largeTax, closeTo(cart.subtotal * 0.20, 0.01));
    });

    test('should apply free shipping threshold correctly', () {
      final product = dummyProducts.first;
      
      // Below threshold
      cart.clear();
      cart.addToCart(product: product, colour: '', size: '', quantity: 1);
      if (cart.subtotal < 50) {
        expect(cart.shipping, 4.99);
      }

      // Above threshold
      cart.clear();
      cart.addToCart(product: product, colour: '', size: '', quantity: 20);
      if (cart.subtotal >= 50) {
        expect(cart.shipping, 0.0);
      }
    });

    test('should handle clearing cart multiple times', () {
      final product = dummyProducts.first;
      
      cart.addToCart(product: product, colour: '', size: '', quantity: 1);
      cart.clear();
      expect(cart.isEmpty, true);
      
      cart.clear();
      expect(cart.isEmpty, true);
      
      cart.clear();
      expect(cart.isEmpty, true);
    });

    test('should handle removing item from cart', () {
      final product = dummyProducts.first;
      
      cart.addToCart(product: product, colour: 'Black', size: 'M', quantity: 1);
      expect(cart.isEmpty, false);
      expect(cart.itemCount, 1);
      
      final item = cart.items.first;
      cart.removeItem(item);
      
      expect(cart.isEmpty, true);
      expect(cart.itemCount, 0);
    });

    test('should calculate total correctly at shipping threshold', () {
      final product = dummyProducts.first;
      
      // Add products to get close to £50
      cart.clear();
      cart.addToCart(product: product, colour: '', size: '', quantity: 6);
      
      final subtotal = cart.subtotal;
      final tax = cart.tax;
      final shipping = cart.shipping;
      final total = cart.total;

      expect(total, closeTo(subtotal + tax + shipping, 0.01));
    });

    test('should handle adding product to empty cart', () {
      expect(cart.isEmpty, true);
      
      final product = dummyProducts.first;
      cart.addToCart(product: product, colour: 'Red', size: 'M', quantity: 1);
      
      expect(cart.isEmpty, false);
      expect(cart.items.first.product.id, product.id);
    });

    test('should maintain item order', () {
      final products = dummyProducts.take(3).toList();
      
      cart.addToCart(product: products[0], colour: '', size: '', quantity: 1);
      cart.addToCart(product: products[1], colour: '', size: '', quantity: 1);
      cart.addToCart(product: products[2], colour: '', size: '', quantity: 1);

      expect(cart.items[0].product.id, products[0].id);
      expect(cart.items[1].product.id, products[1].id);
      expect(cart.items[2].product.id, products[2].id);
    });
  });
}
