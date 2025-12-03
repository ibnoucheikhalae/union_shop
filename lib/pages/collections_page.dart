// lib/pages/collections_page.dart
import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/footer.dart';
import '../models/collection.dart';
// simple placeholder for header callback actions
void _placeholder() {}
class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Reusable header
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
  onCartTap: () {
    Navigator.pushNamed(context, '/cart'); // 👈 NEW
  },
  onMenuTap: _placeholder,
),


            // Main content
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Collections',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // generated list of dummy collections from model
                  for (final collection in kDummyCollections) ...[
                    ListTile(
                      leading: SizedBox(
                        width: 56,
                        height: 56,
                        child: Image.network(
                          collection.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.image_not_supported, color: Colors.grey),
                              ),
                            );
                          },
                        ),
                      ),
                      title: Text(collection.title),
                      subtitle: Text(collection.description),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/collection',
                          arguments: collection,
                        );
                      },
                    ),
                    const Divider(),
                  ],
                ],
              ),
            ),

              // Reusable Footer
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
