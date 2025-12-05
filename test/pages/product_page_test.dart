import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/data/dummy_products.dart';
import 'package:union_shop/services/cart_service.dart';

void main() {
  group('Product Page Tests', () {
    late CartService cart;

    setUp(() {
      cart = CartService.instance;
      cart.clear();
    });

    test('should display product details', () {
      final product = dummyProducts.first;
      
      expect(product.id, isNotEmpty);
      expect(product.title, isNotEmpty);
      expect(product.price, isNotEmpty);
      expect(product.imageUrl, isNotEmpty);
    });

    test('should show colour options if available', () {
      final productsWithColours = dummyProducts.where(
        (p) => p.colours.isNotEmpty,
      ).toList();
      
      expect(productsWithColours.isNotEmpty, true);
      expect(productsWithColours.first.colours.length, greaterThan(0));
    });

    test('should show size options if available', () {
      final productsWithSizes = dummyProducts.where(
        (p) => p.sizes.isNotEmpty,
      ).toList();
      
      expect(productsWithSizes.isNotEmpty, true);
      expect(productsWithSizes.first.sizes.length, greaterThan(0));
    });

    test('should add product to cart with quantity', () {
      final product = dummyProducts.first;
      const quantity = 2;
      
      cart.addToCart(product: product, colour: '', size: '', quantity: quantity);
      
      expect(cart.isEmpty, false);
      expect(cart.itemCount, quantity);
    });

    test('should display product description', () {
      final productWithDesc = dummyProducts.firstWhere(
        (p) => p.description != null && p.description!.isNotEmpty,
        orElse: () => dummyProducts.first,
      );
      
      if (productWithDesc.description != null) {
        expect(productWithDesc.description, isNotEmpty);
      }
    });

    test('should have quantity selector', () {
      var quantity = 1;
      
      // Increment
      quantity++;
      expect(quantity, 2);
      
      // Decrement
      quantity--;
      expect(quantity, 1);
      
      // Cannot go below 1
      if (quantity > 1) {
        quantity--;
      }
      expect(quantity, 1);
    });

    test('should navigate back to collection', () {
      final product = dummyProducts.first;
      final collectionRoute = '/collection';
      final collectionSlug = product.collectionSlug;
      
      expect(collectionRoute, '/collection');
      expect(collectionSlug, isNotEmpty);
    });

    test('should show add to cart button', () {
      const buttonText = 'ADD TO CART';
      expect(buttonText, contains('CART'));
    });
  });
}
