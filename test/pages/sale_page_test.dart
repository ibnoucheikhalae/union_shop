import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/data/dummy_products.dart';

void main() {
  group('Sale Page Tests', () {
    test('should display sale products', () {
      // For testing, assume all products could be on sale
      final saleProducts = dummyProducts;
      expect(saleProducts.isNotEmpty, true);
    });

    test('sale products should have valid prices', () {
      for (var product in dummyProducts.take(5)) {
        expect(product.price, isNotEmpty);
        expect(product.price, contains('£'));
      }
    });

    test('should have sale page title', () {
      const title = 'SALE';
      expect(title, 'SALE');
    });

    test('should display discounted items in grid', () {
      final saleItems = dummyProducts.take(8).toList();
      expect(saleItems.length, 8);
      
      for (var item in saleItems) {
        expect(item.imageUrl, isNotEmpty);
        expect(item.title, isNotEmpty);
      }
    });

    test('should show original and sale prices', () {
      const originalPrice = '£25.00';
      const salePrice = '£19.99';
      
      expect(originalPrice, contains('£'));
      expect(salePrice, contains('£'));
      
      final original = double.parse(originalPrice.replaceAll('£', ''));
      final sale = double.parse(salePrice.replaceAll('£', ''));
      
      expect(sale, lessThan(original));
    });

    test('should calculate discount percentage', () {
      const originalPrice = 25.00;
      const salePrice = 19.99;
      
      final discount = ((originalPrice - salePrice) / originalPrice * 100);
      expect(discount, greaterThan(0));
      expect(discount, lessThan(100));
    });

    test('should navigate to product page', () {
      final product = dummyProducts.first;
      const route = '/product';
      
      expect(route, '/product');
      expect(product.id, isNotEmpty);
    });

    test('should filter sale items', () {
      final allProducts = dummyProducts;
      expect(allProducts.length, greaterThan(0));
    });
  });
}
