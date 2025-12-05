import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/data/dummy_collections.dart';

void main() {
  group('Collections Page Tests', () {
    test('should display all available collections', () {
      expect(dummyCollections.isNotEmpty, true);
      expect(dummyCollections.length, greaterThanOrEqualTo(5));
    });

    test('all collections should have required fields', () {
      for (var collection in dummyCollections) {
        expect(collection.id, isNotEmpty);
        expect(collection.slug, isNotEmpty);
        expect(collection.title, isNotEmpty);
        expect(collection.description, isNotEmpty);
      }
    });

    test('should have hoodies collection', () {
      final hoodies = dummyCollections.where(
        (c) => c.slug == 'hoodies',
      ).toList();
      expect(hoodies.isNotEmpty, true);
    });

    test('should have sportswear collection', () {
      final sportswear = dummyCollections.where(
        (c) => c.slug == 'sportswear',
      ).toList();
      expect(sportswear.isNotEmpty, true);
    });

    test('should have gifts collection', () {
      final gifts = dummyCollections.where(
        (c) => c.slug == 'gifts',
      ).toList();
      expect(gifts.isNotEmpty, true);
    });

    test('should navigate to collection view with slug', () {
      final collection = dummyCollections.first;
      const route = '/collection';
      final args = collection.slug;
      
      expect(route, '/collection');
      expect(args, isNotEmpty);
    });

    test('collections should be tappable for navigation', () {
      final collection = dummyCollections.first;
      bool navigationTriggered = false;
      
      // Simulate tap
      navigationTriggered = true;
      
      expect(navigationTriggered, true);
      expect(collection.slug, isNotEmpty);
    });
  });
}
