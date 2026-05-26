import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]) {
    loadCart();
  }

  static const String _cartKey = 'cart_items';

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString(_cartKey);

    if (cartString != null) {
      final List<dynamic> decoded = jsonDecode(cartString);
      state = decoded
          .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList();
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      state.map((item) => item.toJson()).toList(),
    );
    await prefs.setString(_cartKey, encoded);
  }

  Future<void> addProduct(Product product) async {
    final index = state.indexWhere((item) => item.product.id == product.id);

    if (index == -1) {
      state = [
        ...state,
        CartItem(product: product, quantity: 1),
      ];
    } else {
      final updated = [...state];
      final currentItem = updated[index];
      updated[index] = currentItem.copyWith(
        quantity: currentItem.quantity + 1,
      );
      state = updated;
    }

    await _saveCart();
  }

  Future<void> incrementQuantity(String productId) async {
    final index = state.indexWhere((item) => item.product.id == productId);
    if (index == -1) return;

    final updated = [...state];
    final currentItem = updated[index];
    updated[index] = currentItem.copyWith(
      quantity: currentItem.quantity + 1,
    );
    state = updated;

    await _saveCart();
  }

  Future<void> decrementQuantity(String productId) async {
    final index = state.indexWhere((item) => item.product.id == productId);
    if (index == -1) return;

    final updated = [...state];
    final currentItem = updated[index];

    if (currentItem.quantity > 1) {
      updated[index] = currentItem.copyWith(
        quantity: currentItem.quantity - 1,
      );
      state = updated;
    } else {
      updated.removeAt(index);
      state = updated;
    }

    await _saveCart();
  }

  Future<void> removeProduct(String productId) async {
    state = state.where((item) => item.product.id != productId).toList();
    await _saveCart();
  }

  Future<void> clear() async {
    state = [];
    await _saveCart();
  }
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

final cartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(
    0.0,
    (sum, item) => sum + item.product.price * item.quantity,
  );
});

final cartCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(
    0,
    (sum, item) => sum + item.quantity,
  );
});