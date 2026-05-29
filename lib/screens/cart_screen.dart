import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  String formatPrice(BuildContext context, double price) {
    final locale = Localizations.localeOf(context);

    String symbol;
    switch (locale.languageCode) {
      case 'uk':
        symbol = '₴';
        break;
      case 'pl':
        symbol = 'zł';
        break;
      case 'en':
      default:
        symbol = '\$';
    }

    final format = NumberFormat.currency(
      locale: locale.toString(),
      symbol: symbol,
      decimalDigits: 2,
    );

    return format.format(price);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final cart = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);
    final cartCount = ref.watch(cartCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.cartTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              await ref.read(cartProvider.notifier).clear();
            },
            tooltip: l10n.clearCart,
          ),
        ],
      ),
      body: cart.isEmpty
          ? Center(
              child: Text(
                l10n.cartEmpty,
                style: const TextStyle(fontSize: 18),
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
                            l10n.eachPrice(
                              formatPrice(context, product.price),
                            ),
                          ),
                          trailing: SizedBox(
                            width: 120,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon:
                                      const Icon(Icons.remove_circle_outline),
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
                        l10n.itemsCount(cartCount),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.totalLabel(formatPrice(context, total)),
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
                                title: Text(l10n.orderPlacedTitle),
                                content: Text(l10n.orderPlacedMessage),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(l10n.ok),
                                  ),
                                ],
                              ),
                            );

                            await ref.read(cartProvider.notifier).clear();
                          },
                          child: Text(l10n.checkout),
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