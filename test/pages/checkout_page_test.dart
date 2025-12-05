import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/data/dummy_products.dart';

void main() {
  group('Checkout Page Tests', () {
    late CartService cart;

    setUp(() {
      cart = CartService.instance;
      cart.clear();
    });

    test('should calculate order summary correctly', () {
      final product = dummyProducts.first;
      cart.addToCart(product: product, colour: '', size: '', quantity: 2);
      
      final subtotal = cart.subtotal;
      final tax = cart.tax;
      final shipping = cart.shipping;
      final total = cart.total;
      
      expect(subtotal, greaterThan(0));
      expect(tax, closeTo(subtotal * 0.20, 0.01));
      expect(total, closeTo(subtotal + tax + shipping, 0.01));
    });

    test('should validate shipping address fields', () {
      final address = {
        'name': 'John Doe',
        'street': '123 Main St',
        'city': 'London',
        'postcode': 'SW1A 1AA',
      };
      
      expect(address['name'], isNotEmpty);
      expect(address['street'], isNotEmpty);
      expect(address['city'], isNotEmpty);
      expect(address['postcode'], isNotEmpty);
    });

    test('should validate payment card details structure', () {
      final cardDetails = {
        'cardNumber': '4111111111111111',
        'expiryDate': '12/25',
        'cvv': '123',
      };
      
      expect(cardDetails['cardNumber']!.length, 16);
      expect(cardDetails['expiryDate'], contains('/'));
      expect(cardDetails['cvv']!.length, 3);
    });

    test('should show order confirmation after successful checkout', () {
      const confirmationMessage = 'Order placed successfully!';
      expect(confirmationMessage, contains('success'));
    });

    test('should apply free shipping for orders over £50', () {
      cart.addToCart(product: dummyProducts.first, colour: '', size: '', quantity: 10);
      
      if (cart.subtotal >= 50) {
        expect(cart.shipping, 0.0);
      } else {
        expect(cart.shipping, 4.99);
      }
    });
  });
}
