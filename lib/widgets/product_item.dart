import 'package:flutter/material.dart';
import 'package:flutter_201/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_201/models/product.dart';

class ProductItem extends ConsumerWidget {
  const ProductItem({
    super.key,
    required this.product,
    this.isWishItems = false,
    this.isCartItem = false,
    required this.onSelectItem,
    required this.onRemoveItem,
  });
  final bool? isWishItems;
  final bool? isCartItem;
  final Product product;

  final void Function(Product product) onSelectItem;
  final void Function(Product product) onRemoveItem;

  void addRemoveCartItem(BuildContext context, WidgetRef ref, Product product) {
    final isAdd = ref
        .read(cartViewModelProvider.notifier)
        .addRemoveItem(Cart(pid: product.id));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isAdd ? 'Product added as a cart' : 'Cart removed',
        ),
        duration: Duration(microseconds: 2),
      ),
    );
  }

  void _shearItem(Product product) async {
    await Share.share("Name: ${product.title}\nPrice :${product.price}");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItem = ref.watch(cartViewModelProvider);
    final isCart = cartItem.where((item) => item.pid == product.id).toList();
    return InkWell(
      onTap: () => onSelectItem(product),
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 2,
        child: Stack(
          children: [
            Hero(
              tag: product.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(product.image_url),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis, // very long text
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price : \u20B9${product.price}',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (isCartItem!) {
                              addRemoveCartItem(context, ref, product);
                              onRemoveItem(product);
                            } else if (isWishItems!) {
                              _shearItem(product);
                            } else {
                              addRemoveCartItem(context, ref, product);
                            }
                          },
                          icon: Icon(
                              isWishItems!
                                  ? Icons.share
                                  : (isCart.isNotEmpty
                                      ? Icons.shopping_cart
                                      : Icons.shopping_cart_outlined),
                              size: 20.0,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
