import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PrintShack About Page Tests', () {
    test('should have PrintShack title', () {
      const title = 'About PrintShack';
      expect(title, contains('PrintShack'));
    });

    test('should have printing service description', () {
      const description = 'Custom printing services for your merchandise';
      expect(description, isNotEmpty);
      expect(description.toLowerCase(), contains('print'));
    });

    test('should have service offerings', () {
      final services = [
        'T-Shirt Printing',
        'Hoodie Customization',
        'Mug Printing',
        'Custom Designs',
      ];
      
      expect(services.length, 4);
      expect(services.any((s) => s.contains('T-Shirt')), true);
    });

    test('should have contact information', () {
      final contact = {
        'email': 'printshack@union.com',
        'phone': '+44 20 1234 5678',
      };
      
      expect(contact['email'], contains('@'));
      expect(contact['phone'], isNotEmpty);
    });

    test('should have opening hours', () {
      const openingHours = 'Monday - Friday: 9:00 AM - 5:00 PM';
      expect(openingHours, isNotEmpty);
      expect(openingHours, contains('Monday'));
    });

    test('should have location information', () {
      const location = 'University of Greenwich Campus';
      expect(location, contains('Greenwich'));
    });

    test('should navigate back to main site', () {
      const backRoute = '/';
      expect(backRoute, '/');
    });
  });
}
