import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_201/models/product.dart';
import 'package:flutter_201/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailsScreen extends ConsumerWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(wishViewModelProvider.notifier).loadGifts();
    final items = ref.watch(wishViewModelProvider);
    var isWish = false;
    final wishList = items.where((item) => item.pid == product.id).toList();

    if (wishList.isNotEmpty) {
      isWish = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Platform.isIOS
            ? Align(
                alignment: Alignment.centerLeft,
                child: Text(product.title),
              )
            : Text(product.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded =
                  ref.read(wishViewModelProvider.notifier).addWishItem(
                        WishItem(pid: product.id),
                      );
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      wasAdded ? 'Item added as a wishlist' : 'Item removed'),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.5, end: 1).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isWish ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(isWish),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: product.id,
              child: Image.network(
                product.image_url,
                height: 300,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Details',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Price : \u20B9${product.price}',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.details,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
