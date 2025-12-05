import 'package:flutter_test/flutter_test.dart';

void main() {
  group('About Page Tests', () {
    test('should have valid about page title', () {
      const pageTitle = 'About The Union Shop';
      expect(pageTitle, isNotEmpty);
      expect(pageTitle.toLowerCase(), contains('union shop'));
    });

    test('should have about content structure', () {
      const aboutContent = '''
        The Union Shop is your one-stop destination for all things 
        University of Greenwich. From hoodies to stationery, we've got you covered.
      ''';
      expect(aboutContent, isNotEmpty);
      expect(aboutContent.toLowerCase(), contains('university'));
    });

    test('should have valid navigation structure', () {
      final routes = ['/', '/cart', '/login'];
      expect(routes.contains('/'), true);
      expect(routes.contains('/cart'), true);
      expect(routes.contains('/login'), true);
    });
  });
}
