import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/models/product.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('Cart Service Tests', () {
    setUp(() async {
      // Access internal list to clear it for testing
      final service = CartService.instance;
      // Use the clear method which clears the internal list
      await service.clear();
    });

    test('should add item to cart', () async {
      final product = const Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      await CartService.instance.addToCart(
        product: product,
        colour: 'Black',
        size: 'M',
        quantity: 1,
      );

      final items = CartService.instance.items;
      expect(items.length, 1);
      expect(items.first.product.id, 'test1');
    });

    test('should update quantity when same item added', () async {
      final product = const Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      // Add item twice
      await CartService.instance.addToCart(
        product: product,
        colour: 'Black',
        size: 'M',
        quantity: 1,
      );

      await CartService.instance.addToCart(
        product: product,
        colour: 'Black',
        size: 'M',
        quantity: 2,
      );

      final items = CartService.instance.items;
      expect(items.length, 1);
      expect(items.first.quantity, 3); // Should be combined
    });

    test('should calculate total correctly', () async {
      final product1 = const Product(
        id: 'test1',
        title: 'Product 1',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      final product2 = const Product(
        id: 'test2',
        title: 'Product 2',
        price: '£15.50',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      await CartService.instance.addToCart(
        product: product1,
        colour: 'Black',
        size: 'M',
        quantity: 2,
      );

      await CartService.instance.addToCart(
        product: product2,
        colour: 'Blue',
        size: 'L',
        quantity: 1,
      );

      final subtotal = CartService.instance.subtotal;
      expect(subtotal, 35.50); // (10.00 * 2) + 15.50
    });

    test('should remove item from cart', () async {
      final product = const Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      await CartService.instance.addToCart(
        product: product,
        colour: 'Black',
        size: 'M',
        quantity: 1,
      );

      var items = CartService.instance.items;
      expect(items.length, 1);

      await CartService.instance.removeItem(items.first);

      items = CartService.instance.items;
      expect(items.length, 0);
    });

    test('should clear entire cart', () async {
      final product1 = const Product(
        id: 'test1',
        title: 'Product 1',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      final product2 = const Product(
        id: 'test2',
        title: 'Product 2',
        price: '£15.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      await CartService.instance.addToCart(
        product: product1,
        colour: 'Black',
        size: 'M',
        quantity: 1,
      );

      await CartService.instance.addToCart(
        product: product2,
        colour: 'Blue',
        size: 'L',
        quantity: 1,
      );

      await CartService.instance.clear();

      final items = CartService.instance.items;
      expect(items.length, 0);
    });

    test('should get cart item count', () async {
      final product = const Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      await CartService.instance.addToCart(
        product: product,
        colour: 'Black',
        size: 'M',
        quantity: 3,
      );

      final count = CartService.instance.itemCount;
      expect(count, 3); // Total quantity
    });
  });
}
