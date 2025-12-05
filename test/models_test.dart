import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/data/dummy_products.dart';

void main() {
  group('Product Model Tests', () {
    test('should create product with required fields', () {
      const product = Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      expect(product.id, 'test1');
      expect(product.title, 'Test Product');
      expect(product.price, '£10.00');
      expect(product.collectionSlug, 'test');
      expect(product.imageUrl, 'https://via.placeholder.com/200');
    });

    test('should create product with optional fields', () {
      const product = Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
        description: 'Test description',
        sizes: ['S', 'M', 'L'],
        colours: ['Black', 'White'],
      );

      expect(product.description, 'Test description');
      expect(product.sizes, ['S', 'M', 'L']);
      expect(product.colours, ['Black', 'White']);
    });

    test('should have default empty lists for sizes and colours', () {
      const product = Product(
        id: 'test1',
        title: 'Test Product',
        price: '£10.00',
        collectionSlug: 'test',
        imageUrl: 'https://via.placeholder.com/200',
      );

      expect(product.sizes, isEmpty);
      expect(product.colours, isEmpty);
    });
  });

  group('Dummy Products Tests', () {
    test('should have products defined', () {
      expect(dummyProducts, isNotEmpty);
    });

    test('should have products from different collections', () {
      final collections = dummyProducts.map((p) => p.collectionSlug).toSet();
      
      expect(collections.contains('hoodies'), true);
      expect(collections.contains('sportswear'), true);
      expect(collections.contains('gifts'), true);
      expect(collections.contains('stationery'), true);
      expect(collections.contains('campus-essentials'), true);
    });

    test('all products should have required fields', () {
      for (var product in dummyProducts) {
        expect(product.id, isNotEmpty);
        expect(product.title, isNotEmpty);
        expect(product.price, isNotEmpty);
        expect(product.collectionSlug, isNotEmpty);
      }
    });

    test('all products should have valid prices', () {
      for (var product in dummyProducts) {
        expect(product.price.startsWith('£'), true);
      }
    });

    test('sportswear collection should have 6 products', () {
      final sportswearProducts = dummyProducts
          .where((p) => p.collectionSlug == 'sportswear')
          .toList();
      
      expect(sportswearProducts.length, 6);
    });

    test('gifts collection should have 3 products', () {
      final giftsProducts = dummyProducts
          .where((p) => p.collectionSlug == 'gifts')
          .toList();
      
      expect(giftsProducts.length, 3);
    });

    test('stationery collection should have 3 products', () {
      final stationeryProducts = dummyProducts
          .where((p) => p.collectionSlug == 'stationery')
          .toList();
      
      expect(stationeryProducts.length, 3);
    });

    test('campus essentials collection should have 3 products', () {
      final essentialsProducts = dummyProducts
          .where((p) => p.collectionSlug == 'campus-essentials')
          .toList();
      
      expect(essentialsProducts.length, 3);
    });
  });
}
