import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/models/product.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('Cart Logic Tests', () {
    setUp(() async {
      // Clear cart before each test
      await CartService.instance.clear();
    });

    test('cart should be empty initially', () {
      expect(CartService.instance.isEmpty, true);
      expect(CartService.instance.items.length, 0);
    });

    test('should add product to cart', () async {
      final testProduct = const Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      await CartService.instance.addToCart(
        product: testProduct,
        colour: 'Black',
        size: 'M',
        quantity: 1,
      );

      expect(CartService.instance.items.length, 1);
      expect(CartService.instance.items.first.product.title, 'Test Product');
    });

    test('should calculate subtotal correctly', () async {
      final testProduct1 = const Product(
        id: 'test1',
        title: 'Product 1',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      await CartService.instance.addToCart(
        product: testProduct1,
        colour: 'Black',
        size: 'M',
        quantity: 2,
      );

      expect(CartService.instance.subtotal, 20.00);
    });

    test('should calculate total with tax and shipping', () async {
      final testProduct = const Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      await CartService.instance.addToCart(
        product: testProduct,
        colour: 'Black',
        size: 'M',
        quantity: 1,
      );

      final subtotal = CartService.instance.subtotal;
      final tax = CartService.instance.tax;
      final shipping = CartService.instance.shipping;
      final total = CartService.instance.total;

      expect(subtotal, 10.00);
      expect(tax, 2.00); // 20% of 10
      expect(shipping, 4.99); // Under £50, so shipping applies
      expect(total, closeTo(16.99, 0.01)); // Use closeTo for floating point comparison
    });

    test('should remove item from cart', () async {
      final testProduct = const Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      await CartService.instance.addToCart(
        product: testProduct,
        colour: 'Black',
        size: 'M',
        quantity: 1,
      );

      expect(CartService.instance.items.length, 1);

      final item = CartService.instance.items.first;
      await CartService.instance.removeItem(item);

      expect(CartService.instance.items.length, 0);
      expect(CartService.instance.isEmpty, true);
    });

    test('should update item quantity', () async {
      final testProduct = const Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      await CartService.instance.addToCart(
        product: testProduct,
        colour: 'Black',
        size: 'M',
        quantity: 1,
      );

      final item = CartService.instance.items.first;
      await CartService.instance.updateQuantity(item, 3);

      expect(CartService.instance.items.first.quantity, 3);
      expect(CartService.instance.subtotal, 30.00);
    });
  });
}
