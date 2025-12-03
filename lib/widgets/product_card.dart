// lib/widgets/product_card.dart
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/cart_service.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final String? id;
  final String? collectionSlug;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.id,
    this.collectionSlug,
  });
@override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // For now, always navigate to the generic product page
        Navigator.pushNamed(context, '/product');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    final product = Product(
                      id: id ?? title,
                      title: title,
                      price: price,
                      collectionSlug: collectionSlug ?? '',
                      imageUrl: imageUrl,
                    );
                    CartService.instance.addToCart(
                      product: product,
                      colour: '',
                      size: '',
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to cart')),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}