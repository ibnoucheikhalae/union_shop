// lib/pages/collections_page.dart
import 'package:flutter/material.dart';

import '../widgets/app_header.dart';
import '../widgets/footer.dart';
import '../data/dummy_collections.dart';
import '../models/collection.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  String _sortOrder = 'az';
  String _categoryFilter = 'all';
  int _currentPage = 0;
  static const int _pageSize = 3;

  void _placeholder() {}

  void _openCollection(BuildContext context, Collection collection) {
    Navigator.pushNamed(
      context,
      '/collection',
      arguments: collection.slug,
    );
  }

  List<Collection> get _filteredAndSorted {
    // 1. Filter by category
    List<Collection> result = dummyCollections;
    if (_categoryFilter != 'all') {
      result = result
          .where((c) => c.category == _categoryFilter)
          .toList();
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

  List<Collection> get _pagedCollections {
    final list = _filteredAndSorted;
    final start = _currentPage * _pageSize;
    if (start >= list.length) return [];
    final end = (start + _pageSize).clamp(0, list.length);
    return list.sublist(start, end);
  }

  int get _totalPages {
    final list = _filteredAndSorted;
    if (list.isEmpty) return 1;
    return (list.length / _pageSize).ceil();
  }

  void _goToPage(int page) {
    setState(() {
      _currentPage = page.clamp(0, _totalPages - 1);
    });
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
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _sortOrder = value;
                              _currentPage = 0;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _categoryFilter,
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'all',
                              child: Text('All categories'),
                            ),
                            DropdownMenuItem(
                              value: 'clothing',
                              child: Text('Clothing'),
                            ),
                            DropdownMenuItem(
                              value: 'gifts',
                              child: Text('Gifts'),
                            ),
                            DropdownMenuItem(
                              value: 'stationery',
                              child: Text('Stationery'),
                            ),
                            DropdownMenuItem(
                              value: 'essentials',
                              child: Text('Essentials'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _categoryFilter = value;
                              _currentPage = 0;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

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

                  // 🔽 Pagination controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed:
                            _currentPage > 0 ? () => _goToPage(_currentPage - 1) : null,
                        icon: const Icon(Icons.chevron_left),
                      ),
                      Text(
                        'Page ${_currentPage + 1} of $_totalPages',
                        style: const TextStyle(fontSize: 14),
                      ),
                      IconButton(
                        onPressed: (_currentPage < _totalPages - 1)
                            ? () => _goToPage(_currentPage + 1)
                            : null,
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
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
