import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              await ref.read(cartProvider.notifier).clear();
            },
          ),
        ],
      ),
      body: cart.isEmpty
          ? const Center(
              child: Text(
                'Cart is empty',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      final product = item.product;

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: Text(
                            product.image,
                            style: const TextStyle(fontSize: 28),
                          ),
                          title: Text('${product.name} x${item.quantity}'),
                          subtitle: Text(
                            '\$${product.price.toStringAsFixed(2)} each',
                          ),
                          trailing: SizedBox(
                            width: 120,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () async {
                                    await ref
                                        .read(cartProvider.notifier)
                                        .decrementQuantity(product.id);
                                  },
                                ),
                                Text('${item.quantity}'),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () async {
                                    await ref
                                        .read(cartProvider.notifier)
                                        .incrementQuantity(product.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Items: ${ref.watch(cartCountProvider)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total: \$${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Order placed'),
                                content: const Text(
                                  'Your order has been successfully placed!',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );

                            await ref.read(cartProvider.notifier).clear();
                          },
                          child: const Text('Checkout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}