// lib/pages/collections_page.dart
import 'package:flutter/material.dart';

import '../widgets/app_header.dart';
import '../widgets/footer.dart';
import '../data/dummy_collections.dart';
import '../models/collection.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  void _placeholder() {}

  void _openCollection(BuildContext context, Collection collection) {
    Navigator.pushNamed(
      context,
      '/collection',
      arguments: collection.slug, // we’ll use this later
    );
  }
// 2. Sort
    result = List<Collection>.from(result); // copy
    if (_sortOrder == 'az') {
      result.sort((a, b) => a.title.compareTo(b.title));
    } else if (_sortOrder == 'za') {
      result.sort((a, b) => b.title.compareTo(a.title));
    }

    return result;
  }
  @override
  Widget build(BuildContext context) {
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
              // 🔽 Filters & sorting
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _sortOrder,
                          decoration: const InputDecoration(
                            labelText: 'Sort by',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'az',
                              child: Text('Name A–Z'),
                            ),
                            DropdownMenuItem(
                              value: 'za',
                              child: Text('Name Z–A'),
                            ),
                          ],
              // 🔽 Collections list (paged)
                  if (_pagedCollections.isEmpty)
                    const Text(
                      'No collections match your filters.',
                      style: TextStyle(fontSize: 16),
                    )
                  else
                    ..._pagedCollections.map(
                      (collection) => Column(
                        children: [
                          ListTile(
                            title: Text(collection.title),
                            subtitle: Text(collection.description),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => _openCollection(context, collection),
                          ),
                          const Divider(),
                        ],
                      ),
                    ),

                  const SizedBox(height: 16),

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
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Dynamic list of collections from dummy_collections.dart
                  ...dummyCollections.map(
                    (collection) => Column(
                      children: [
                        ListTile(
                          title: Text(collection.title),
                          subtitle: Text(collection.description),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _openCollection(context, collection),
                        ),
                        const Divider(),
                      ],
                    ),
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


