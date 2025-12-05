import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/footer.dart';

void main() {
  group('Footer Widget Tests', () {
    testWidgets('should display footer with opening hours', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AppFooter(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Opening Hours'), findsOneWidget);
    });

    testWidgets('should display winter break information', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AppFooter(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('Winter Break'), findsOneWidget);
    });

    testWidgets('should display copyright information', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AppFooter(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('©'), findsWidgets);
    });

    testWidgets('should render without errors', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AppFooter(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(AppFooter), findsOneWidget);
    });

    test('should be a const constructor', () {
      const footer1 = AppFooter();
      const footer2 = AppFooter();
      
      expect(footer1, isA<AppFooter>());
      expect(footer2, isA<AppFooter>());
    });
  });
}
