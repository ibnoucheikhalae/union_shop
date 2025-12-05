// lib/pages/collections_page.dart
import 'package:flutter/material.dart';

import '../widgets/app_header.dart';
import '../widgets/footer.dart';
import '../widgets/collection_card.dart';
import '../data/dummy_collections.dart';
import '../models/collection.dart';

// (collection image mapping removed; collections use their own imageUrl field)

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  void _placeholder() {}

  void _openCollection(BuildContext context, Collection collection) {
    // Special case: if it's the sale collection, navigate to the sale page
    if (collection.slug == 'sale') {
      Navigator.pushNamed(context, '/sale');
    } else {
      Navigator.pushNamed(
        context,
        '/collection',
        arguments: collection.slug,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // for this “dummy collections page” we just show all collections
    final List<Collection> collections = dummyCollections;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
              onAccountTap: () {
                Navigator.pushNamed(context, '/login');
              },
              onCartTap: () {
                Navigator.pushNamed(context, '/cart');
              },
              onMenuTap: _placeholder,
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Collections',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // GRID OF COLLECTION TILES (like screenshot 1)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 
                        MediaQuery.of(context).size.width > 900 ? 3 :
                        MediaQuery.of(context).size.width > 600 ? 2 : 1,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: collections.length,
                    itemBuilder: (context, index) {
                      final collection = collections[index];

                      return CollectionCard(
                        collection: collection,
                        onTap: () => _openCollection(context, collection),
                      );
                    },
                  ),
                ],
              ),
            ),

            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
