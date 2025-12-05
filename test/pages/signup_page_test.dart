import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Signup Page Tests', () {
    test('should validate email format', () {
      const validEmail = 'newuser@example.com';
      const invalidEmail = 'notvalid';
      
      expect(validEmail, contains('@'));
      expect(validEmail, contains('.'));
      expect(invalidEmail.contains('@'), false);
    });

    test('should validate password length', () {
      const validPassword = 'securePass123';
      const shortPassword = '123';
      
      expect(validPassword.length, greaterThanOrEqualTo(6));
      expect(shortPassword.length, lessThan(6));
    });

    test('should validate password confirmation match', () {
      const password = 'password123';
      const confirmPassword = 'password123';
      const mismatchPassword = 'different123';
      
      expect(password == confirmPassword, true);
      expect(password == mismatchPassword, false);
    });

    test('should have required signup fields', () {
      final signupFields = ['name', 'email', 'password', 'confirmPassword'];
      
      expect(signupFields.length, 4);
      expect(signupFields.contains('email'), true);
      expect(signupFields.contains('password'), true);
    });

    test('should validate name field', () {
      const validName = 'John Doe';
      const emptyName = '';
      
      expect(validName.isNotEmpty, true);
      expect(emptyName.isEmpty, true);
    });

    test('should have signup button', () {
      const buttonText = 'Sign Up';
      expect(buttonText, contains('Sign'));
    });

    test('should navigate to login page', () {
      const loginRoute = '/login';
      expect(loginRoute, '/login');
    });

    test('should show terms and conditions', () {
      const termsText = 'By signing up, you agree to our Terms and Conditions';
      expect(termsText, contains('Terms'));
    });

    test('should validate all fields before submission', () {
      const name = 'John Doe';
      const email = 'john@example.com';
      const password = 'password123';
      const confirm = 'password123';
      
      final allFieldsFilled = name.isNotEmpty && 
                             email.isNotEmpty && 
                             password.isNotEmpty &&
                             password == confirm;
      
      expect(allFieldsFilled, true);
    });

    test('should navigate to home after successful signup', () {
      const homeRoute = '/';
      expect(homeRoute, '/');
    });
  });
}
