import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';

final productsProvider = Provider<List<Product>>((ref) {
  return const [
    Product(
      id: '1',
      name: 'iPhone 14',
      price: 999.99,
      category: 'Phone',
      image: '📱',
    ),
    Product(
      id: '2',
      name: 'MacBook Pro',
      price: 1999.99,
      category: 'Laptop',
      image: '💻',
    ),
    Product(
      id: '3',
      name: 'Apple Watch',
      price: 399.99,
      category: 'Watch',
      image: '⌚',
    ),
  ];
});

final selectedCategoryProvider = StateProvider<String?>((ref) => null);

final categoriesProvider = Provider<List<String>>((ref) {
  final products = ref.watch(productsProvider);
  final categories = products.map((p) => p.category).toSet().toList();
  categories.sort();
  return categories;
});

final filteredProductsProvider = Provider<List<Product>>((ref) {
  final products = ref.watch(productsProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);

  if (selectedCategory == null) {
    return products;
  }

  return products.where((p) => p.category == selectedCategory).toList();
});