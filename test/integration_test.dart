import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/services/search_service.dart';
import 'package:union_shop/data/dummy_products.dart';
import 'package:union_shop/data/dummy_collections.dart';

void main() {
  group('Integration Tests - Shopping Flow', () {
    late CartService cart;

    setUp(() {
      cart = CartService.instance;
      cart.clear();
    });

    test('complete shopping flow: browse -> search -> add to cart -> checkout', () {
      // Step 1: Browse collections
      expect(dummyCollections.isNotEmpty, true);
      final collection = dummyCollections.first;
      
      // Step 2: View products in collection
      final collectionProducts = dummyProducts.where(
        (p) => p.collectionSlug == collection.slug,
      ).toList();
      expect(collectionProducts.isNotEmpty, true);
      
      // Step 3: Search for a product
      final searchResults = SearchService.searchProducts('hoodie');
      expect(searchResults.isNotEmpty, true);
      
      // Step 4: Add product to cart
      final product = searchResults.first;
      cart.addToCart(
        product: product,
        colour: 'Black',
        size: 'M',
        quantity: 2,
      );
      expect(cart.isEmpty, false);
      expect(cart.itemCount, 2);
      
      // Step 5: View cart totals
      expect(cart.subtotal, greaterThan(0));
      expect(cart.tax, greaterThan(0));
      expect(cart.total, greaterThan(cart.subtotal));
      
      // Step 6: Proceed to checkout (validate totals)
      final finalTotal = cart.total;
      expect(finalTotal, closeTo(cart.subtotal + cart.tax + cart.shipping, 0.01));
    });

    test('multi-product shopping flow', () {
      // Browse multiple collections
      final hoodie = dummyProducts.firstWhere(
        (p) => p.collectionSlug == 'hoodies',
      );
      final sportswear = dummyProducts.firstWhere(
        (p) => p.collectionSlug == 'sportswear',
      );
      
      // Add multiple products
      cart.addToCart(product: hoodie, colour: 'Navy', size: 'L', quantity: 1);
      cart.addToCart(product: sportswear, colour: 'Red', size: 'M', quantity: 2);
      
      expect(cart.items.length, 2);
      expect(cart.itemCount, 3);
      
      // Verify cart calculations
      expect(cart.subtotal, greaterThan(0));
      expect(cart.total, greaterThan(0));
    });

    test('search and filter flow', () {
      // Search for products
      final searchQuery = 'hoodie';
      final allResults = SearchService.searchProducts(searchQuery);
      
      // Filter by collection
      final hoodieCollection = allResults.where(
        (p) => p.collectionSlug == 'hoodies',
      ).toList();
      
      expect(hoodieCollection.isNotEmpty, true);
      
      // Add filtered product to cart
      if (hoodieCollection.isNotEmpty) {
        cart.addToCart(
          product: hoodieCollection.first,
          colour: 'Black',
          size: 'L',
          quantity: 1,
        );
        expect(cart.isEmpty, false);
      }
    });

    test('cart modification flow', () {
      final product = dummyProducts.first;
      
      // Add product
      cart.addToCart(product: product, colour: 'Blue', size: 'M', quantity: 1);
      expect(cart.itemCount, 1);
      
      // Increase quantity
      cart.addToCart(product: product, colour: 'Blue', size: 'M', quantity: 2);
      expect(cart.itemCount, 3);
      expect(cart.items.length, 1); // Still one item, quantity increased
      
      // Remove item
      final item = cart.items.first;
      cart.removeItem(item);
      expect(cart.isEmpty, true);
    });

    test('collection browsing to purchase flow', () {
      // Browse a specific collection
      const targetSlug = 'sportswear';
      final products = dummyProducts.where(
        (p) => p.collectionSlug == targetSlug,
      ).toList();
      
      expect(products.isNotEmpty, true);
      
      // Select first two products
      final product1 = products[0];
      final product2 = products[1];
      
      // Add to cart
      cart.addToCart(product: product1, colour: 'Red', size: 'S', quantity: 1);
      cart.addToCart(product: product2, colour: 'Blue', size: 'M', quantity: 1);
      
      expect(cart.items.length, 2);
      
      // Check cart summary
      expect(cart.subtotal, greaterThan(0));
      expect(cart.tax, closeTo(cart.subtotal * 0.20, 0.01));
    });

    test('shipping threshold crossing flow', () {
      final product = dummyProducts.first;
      
      // Add small amount (below £50)
      cart.addToCart(product: product, colour: 'Black', size: 'M', quantity: 1);
      
      if (cart.subtotal < 50) {
        expect(cart.shipping, 4.99);
        final totalWithShipping = cart.total;
        
        // Add more to cross threshold
        cart.addToCart(product: product, colour: 'Black', size: 'M', quantity: 10);
        
        if (cart.subtotal >= 50) {
          expect(cart.shipping, 0.0);
          expect(cart.total, greaterThan(totalWithShipping));
        }
      }
    });

    test('empty cart to purchase flow', () {
      // Start with empty cart
      expect(cart.isEmpty, true);
      expect(cart.itemCount, 0);
      expect(cart.subtotal, 0.0);
      
      // Search and add product
      final results = SearchService.searchProducts('gift');
      if (results.isNotEmpty) {
        final product = results.first;
        cart.addToCart(product: product, colour: '', size: '', quantity: 1);
        
        expect(cart.isEmpty, false);
        expect(cart.itemCount, 1);
        expect(cart.subtotal, greaterThan(0));
      }
    });

    test('product variants flow', () {
      final product = dummyProducts.firstWhere(
        (p) => p.colours.isNotEmpty && p.sizes.isNotEmpty,
      );
      
      // Add same product with different variants
      cart.addToCart(
        product: product,
        colour: product.colours.first,
        size: product.sizes.first,
        quantity: 1,
      );
      
      if (product.colours.length > 1) {
        cart.addToCart(
          product: product,
          colour: product.colours[1],
          size: product.sizes.first,
          quantity: 1,
        );
        
        // Should have 2 separate items
        expect(cart.items.length, 2);
        expect(cart.itemCount, 2);
      }
    });
  });

  group('Integration Tests - Collection Flows', () {
    test('browse all collections and count products', () {
      var totalProducts = 0;
      
      for (var collection in dummyCollections) {
        final products = dummyProducts.where(
          (p) => p.collectionSlug == collection.slug,
        ).toList();
        
        totalProducts += products.length;
        expect(products.isNotEmpty, true,
            reason: 'Collection ${collection.slug} should have products');
      }
      
      expect(totalProducts, greaterThan(0));
    });

    test('verify all collections are searchable', () {
      for (var collection in dummyCollections) {
        final results = SearchService.searchProducts(collection.slug);
        expect(results.isNotEmpty, true,
            reason: 'Should find products for ${collection.slug}');
      }
    });
  });
}
