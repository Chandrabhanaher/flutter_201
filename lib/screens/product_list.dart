import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_201/models/product.dart';
import 'package:flutter_201/screens/product_details.dart';
import 'package:flutter_201/widgets/product_item.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({
    super.key,
    this.title,
    this.isWish = false,
    this.isCart = false,
    required this.products,
  });

  final String? title;
  final bool? isWish;
  final bool? isCart;
  final List<Product> products;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  void _selectProduct(BuildContext context, Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ProductDetailsScreen(product: product),
      ),
    );
  }

  void _removeItem(BuildContext context, Product product) {
    setState(() {
      widget.products.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh...... nothing here!',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a diffrent category!',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
    );

    if (widget.products.isNotEmpty) {
      content = ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (ctx, index) => ProductItem(
          isWishItems: widget.isWish,
          isCartItem: widget.isCart,
          product: widget.products[index],
          onSelectItem: (item) =>
              _selectProduct(context, widget.products[index]),
          onRemoveItem: (item) => _removeItem(context, widget.products[index]),
        ),
      );
    }

    if (widget.title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Platform.isIOS
            ? Align(
                alignment: Alignment.centerLeft,
                child: Text(widget.title!),
              )
            : Text(widget.title!),
      ),
      body: content,
    );
  }
}
