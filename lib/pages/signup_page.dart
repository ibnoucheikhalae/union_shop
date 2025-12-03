import 'package:flutter/material.dart';
import '../widgets/app_header.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _placeholder() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Reusable Header
            AppHeader(
              onLogoTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
              onSearchTap: _placeholder,
              onAccountTap: _placeholder,
              onCartTap: _placeholder,
              onMenuTap: _placeholder,
            ),

            // Page Content
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 16),

                  Text(
                    'Placeholder Login page for the Union Shop.\n\n'
                    'Students should implement the login functionality '
                    'here to access their accounts, view order history, '
                    'and manage personal details.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Footer
          ],
        ),
      ),
    );
  }
}