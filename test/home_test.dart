import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/data/dummy_products.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('Home Page Tests', () {
    testWidgets('dummy products should be properly defined', (tester) async {
      // Test that dummy products are valid
      expect(dummyProducts.isNotEmpty, true);
      expect(dummyProducts['hoodies']!.isNotEmpty, true);
      
      final hoodie = dummyProducts['hoodies']!.first;
      expect(hoodie.id, isNotEmpty);
      expect(hoodie.title, isNotEmpty);
      expect(hoodie.price, isNotEmpty);
    });

    testWidgets('should have products in all collections', (tester) async {
      // Check that all major collections have products
      expect(dummyProducts.containsKey('hoodies'), true);
      expect(dummyProducts.containsKey('sportswear'), true);
      expect(dummyProducts.containsKey('gifts'), true);
      expect(dummyProducts.containsKey('stationery'), true);
      expect(dummyProducts.containsKey('campus-essentials'), true);
    });

    test('products should have valid image URLs', () {
      dummyProducts.forEach((collection, products) {
        for (var product in products) {
          expect(product.imageUrl, isNotEmpty);
          expect(product.imageUrl.startsWith('http'), true);
        }
      });
    });

    test('products should have valid prices', () {
      dummyProducts.forEach((collection, products) {
        for (var product in products) {
          expect(product.price, isNotEmpty);
          expect(product.price.contains('£'), true);
        }
      });
    });
  });
}
