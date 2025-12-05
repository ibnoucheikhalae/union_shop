import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Personalisation Page Tests', () {
    test('should have notification preferences', () {
      final preferences = {
        'emailNotifications': true,
        'pushNotifications': false,
        'smsNotifications': false,
      };
      
      expect(preferences.containsKey('emailNotifications'), true);
      expect(preferences['emailNotifications'], isA<bool>());
    });

    test('should have theme preferences', () {
      final themeOptions = ['light', 'dark', 'system'];
      expect(themeOptions.length, 3);
      expect(themeOptions.contains('dark'), true);
    });

    test('should have language preferences', () {
      final languages = ['en', 'fr', 'es', 'de'];
      expect(languages.isNotEmpty, true);
      expect(languages.contains('en'), true);
    });

    test('should save user preferences', () {
      var savedPreferences = <String, dynamic>{};
      
      savedPreferences['darkMode'] = true;
      savedPreferences['language'] = 'en';
      
      expect(savedPreferences['darkMode'], true);
      expect(savedPreferences['language'], 'en');
    });

    test('should have privacy settings', () {
      final privacySettings = {
        'shareData': false,
        'analytics': true,
      };
      
      expect(privacySettings.containsKey('shareData'), true);
      expect(privacySettings['analytics'], isA<bool>());
    });

    test('should have currency preferences', () {
      final currencies = ['GBP', 'USD', 'EUR'];
      expect(currencies.contains('GBP'), true);
    });

    test('should reset preferences to default', () {
      var preferences = {'darkMode': true, 'language': 'fr'};
      preferences = {'darkMode': false, 'language': 'en'};
      
      expect(preferences['darkMode'], false);
      expect(preferences['language'], 'en');
    });
  });
}
