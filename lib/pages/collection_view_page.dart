import 'package:flutter/material.dart';
import '../widgets/app_header.dart';

class CollectionViewPage extends StatelessWidget {
  const CollectionViewPage({super.key});

  void _placeholder() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
          const Expanded(
            child: Center(child: Text("Collection content goes here")),
          ),
        ],
      ),
    );
  }
}
