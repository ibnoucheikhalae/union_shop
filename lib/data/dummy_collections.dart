// lib/data/dummy_collections.dart
import '../models/collection.dart';

const List<Collection> dummyCollections = [
  Collection(
    id: 'c1',
    slug: 'hoodies',
    title: 'Hoodies & Sweatshirts',
    description: 'Warm and comfy uni hoodies for everyday campus life.',
    category: 'clothing',
    imageUrl: 'assets/images/product/p1.png',
  ),

  Collection(
    id: 'c2',
    slug: 'gifts',
    title: 'Gifts & Accessories',
    description: 'Mugs, magnets, keyrings and small presents.',
    category: 'gifts',
    imageUrl:  'assets/images/product/p4.png',
  ),
  Collection(
    id: 'c3',
    slug: 'stationery',
    title: 'Stationery',
    description: 'Notebooks, pens, and study essentials.',
    category: 'stationery',
    imageUrl: 'assets/images/product/p2.png',
  ),
  Collection(
    id: 'c4',
    slug: 'sportswear',
    title: 'Sportswear',
    description: 'Activewear for BUCS teams and gym sessions.',
    category: 'clothing',
    imageUrl: 'assets/images/product/p3.png',
  ),
  Collection(
    id: 'c5',
    slug: 'campus-essentials',
    title: 'Campus Essentials',
    description: 'Everyday bits you need around campus.',
    category: 'essentials',
    imageUrl: 'assets/images/product/p5.png',
  ),
  Collection(
  id: 'c6',
  slug: 'sale',
  title: 'Sale Items',
  description: 'Discounted items — limited time offers.',
  category: 'sales',
  imageUrl: 'assets/images/product/p1.png',
),
];