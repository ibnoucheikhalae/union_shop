// lib/pages/collections_page.dart
import 'package:flutter/material.dart';

import '../widgets/app_header.dart';
import '../widgets/footer.dart';
import '../data/dummy_collections.dart';
import '../models/collection.dart';

/// Simple map of images for each collection slug (hard-coded = allowed)
const Map<String, String> _collectionImages = {
  'autumn-favourites':
      'https://shop.upsu.net/cdn/shop/files/AutumnFavourites_1024x1024.jpg?v=1',
  'black-friday':
      'https://shop.upsu.net/cdn/shop/files/BlackFriday_1024x1024.jpg?v=1',
  'clothing':
      'https://shop.upsu.net/cdn/shop/files/ClothingPurpleHoodie_1024x1024.jpg?v=1',
  'original-clothing':
      'https://shop.upsu.net/cdn/shop/files/OriginalClothing_1024x1024.jpg?v=1',
  'election-discounts':
      'https://shop.upsu.net/cdn/shop/files/ElectionDiscounts_1024x1024.jpg?v=1',
  'essential-range':
      'https://shop.upsu.net/cdn/shop/files/EssentialRange_1024x1024.jpg?v=1',
'sale': 'https://shop.upsu.net/cdn/shop/files/sale-banner_1024x1024.jpg?v=1',
};

const String _fallbackCollectionImage =
    'https://via.placeholder.com/600x800?text=Collection';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  void _placeholder() {}

  void _openCollection(BuildContext context, Collection collection) {
    Navigator.pushNamed(
      context,
      '/collection',
      arguments: collection.slug,
    );
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
                          MediaQuery.of(context).size.width > 800 ? 3 : 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: collections.length,
                    itemBuilder: (context, index) {
                      final collection = collections[index];
                      final imageUrl = _collectionImages[collection.slug] ??
                          _fallbackCollectionImage;

                      return GestureDetector(
                        onTap: () => _openCollection(context, collection),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Use network image (remote) directly. Previously
                              // this tried a local asset then fell back to network.
                              // We now rely on remote images only so they load
                              // without an assets entry in `pubspec.yaml`.
                              Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, _, __) => Container(
                                  color: Colors.grey[300],
                                ),
                              ),
                              // dark overlay
                              Container(
                                color: Colors.black.withOpacity(0.35),
                              ),
                              // collection title in the middle
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    collection.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
