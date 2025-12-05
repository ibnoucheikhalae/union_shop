import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('Cart Item Model Tests', () {
    test('should create cart item with required fields', () {
      const product = Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://test.com/image.jpg',
      );

      final cartItem = CartItem(
        product: product,
        colour: 'Black',
        size: 'M',
        quantity: 2,
      );

      expect(cartItem.product.id, 'test1');
      expect(cartItem.colour, 'Black');
      expect(cartItem.size, 'M');
      expect(cartItem.quantity, 2);
    });

    test('should calculate unit price correctly', () {
      const product = Product(
        id: 'test1',
        title: 'Test Product',
        price: '£15.99',
        collectionSlug: 'test',
        imageUrl: 'https://test.com/image.jpg',
      );

      final cartItem = CartItem(
        product: product,
        colour: 'Red',
        size: 'L',
      );

      expect(cartItem.unitPriceValue, closeTo(15.99, 0.01));
    });

    test('should calculate line total correctly', () {
      const product = Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://test.com/image.jpg',
      );

      final cartItem = CartItem(
        product: product,
        colour: 'Blue',
        size: 'S',
        quantity: 3,
      );

      expect(cartItem.lineTotal, closeTo(30.00, 0.01));
    });

    test('should serialize to JSON correctly', () {
      const product = Product(
        id: 'prod123',
        title: 'Hoodie',
        price: '£25.00',
        collectionSlug: 'hoodies',
        imageUrl: 'https://test.com/hoodie.jpg',
      );

      final cartItem = CartItem(
        product: product,
        colour: 'Navy',
        size: 'XL',
        quantity: 2,
      );

      final json = cartItem.toJson();

      expect(json['productId'], 'prod123');
      expect(json['productTitle'], 'Hoodie');
      expect(json['productPrice'], '£25.00');
      expect(json['productCollectionSlug'], 'hoodies');
      expect(json['productImageUrl'], 'https://test.com/hoodie.jpg');
      expect(json['colour'], 'Navy');
      expect(json['size'], 'XL');
      expect(json['quantity'], 2);
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'productId': 'prod456',
        'productTitle': 'T-Shirt',
        'productPrice': '£12.99',
        'productCollectionSlug': 'sportswear',
        'productImageUrl': 'https://test.com/tshirt.jpg',
        'colour': 'White',
        'size': 'M',
        'quantity': 1,
      };

      final cartItem = CartItem.fromJson(json);

      expect(cartItem.product.id, 'prod456');
      expect(cartItem.product.title, 'T-Shirt');
      expect(cartItem.product.price, '£12.99');
      expect(cartItem.product.collectionSlug, 'sportswear');
      expect(cartItem.product.imageUrl, 'https://test.com/tshirt.jpg');
      expect(cartItem.colour, 'White');
      expect(cartItem.size, 'M');
      expect(cartItem.quantity, 1);
    });

    test('should handle JSON round-trip correctly', () {
      const product = Product(
        id: 'test1',
        title: 'Test Product',
        price: '£20.00',
        collectionSlug: 'test',
        imageUrl: 'https://test.com/image.jpg',
      );

      final originalItem = CartItem(
        product: product,
        colour: 'Green',
        size: 'L',
        quantity: 5,
      );

      final json = originalItem.toJson();
      final deserializedItem = CartItem.fromJson(json);

      expect(deserializedItem.product.id, originalItem.product.id);
      expect(deserializedItem.product.title, originalItem.product.title);
      expect(deserializedItem.colour, originalItem.colour);
      expect(deserializedItem.size, originalItem.size);
      expect(deserializedItem.quantity, originalItem.quantity);
    });

    test('should update quantity', () {
      const product = Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://test.com/image.jpg',
      );

      final cartItem = CartItem(
        product: product,
        colour: 'Red',
        size: 'M',
        quantity: 1,
      );

      cartItem.quantity = 3;
      expect(cartItem.quantity, 3);
      expect(cartItem.lineTotal, closeTo(30.00, 0.01));
    });

    test('should handle price with special formatting', () {
      const product = Product(
        id: 'test1',
        title: 'Test Product',
        price: 'GBP £9.99',
        collectionSlug: 'test',
        imageUrl: 'https://test.com/image.jpg',
      );

      final cartItem = CartItem(
        product: product,
        colour: 'Black',
        size: 'S',
      );

      expect(cartItem.unitPriceValue, closeTo(9.99, 0.01));
    });
  });
}
