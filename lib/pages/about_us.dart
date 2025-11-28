import 'package:flutter/material.dart';
import '../widgets/app_header.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  void _placeholder() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppHeader(
            onLogoTap: () {},
            onSearchTap: _placeholder,
            onAccountTap: _placeholder,
            onCartTap: _placeholder,
            onMenuTap: _placeholder,
          ),
        ],
      ),
    );
  }
}
