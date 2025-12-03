// lib/pages/cart_page.dart
import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/footer.dart';
import '../services/cart_service.dart';
import '../models/cart_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    CartService.instance.items.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    CartService.instance.items.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final List<CartItem> items = CartService.instance.items.value;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppHeader(
              onLogoTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false),
              onSearchTap: () {},
              onAccountTap: () {},
              onCartTap: () => Navigator.pushNamed(context, '/cart'),
              onMenuTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Your Cart', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  if (items.isEmpty)
                    const Text('Your shopping cart is currently empty.')
                  else ...[
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, i) {
                        final ci = items[i];
                        return Row(
                          children: [
                            Expanded(
                              child: Text(ci.product.title, style: const TextStyle(fontSize: 16)),
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                CartService.instance.setQuantity(ci.product.id, ci.quantity - 1);
                              },
                            ),
                            Text('${ci.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () {
                                CartService.instance.setQuantity(ci.product.id, ci.quantity + 1);
                              },
                            ),
                            const SizedBox(width: 12),
                            Text('£${ci.totalPrice.toStringAsFixed(2)}'),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () {
                                CartService.instance.removeProduct(ci.product.id);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Text('Total: £${CartService.instance.total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Checkout: show confirmation and clear cart
                            final total = CartService.instance.total;
                            CartService.instance.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Order placed — total: £${total.toStringAsFixed(2)}')),
                            );
                          },
                          child: const Text('Place Order'),
                        ),
                        const SizedBox(width: 12),
                        TextButton(
                          onPressed: () {
                            CartService.instance.clear();
                          },
                          child: const Text('Clear Cart'),
                        ),
                      ],
                    ),
                  ],
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