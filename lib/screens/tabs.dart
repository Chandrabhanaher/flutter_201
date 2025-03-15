import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_201/models/product.dart';
import 'package:flutter_201/providers/providers.dart';
import 'package:flutter_201/screens/categories.dart';
import 'package:flutter_201/screens/product_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomMenuScreen extends ConsumerStatefulWidget {
  const BottomMenuScreen({super.key});
  @override
  ConsumerState<BottomMenuScreen> createState() => _BottomMenuScreenState();
}

class _BottomMenuScreenState extends ConsumerState<BottomMenuScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _cartItem(BuildContext context) async {
    await ref.read(cartViewModelProvider.notifier).loadCart();
    await ref.read(productViewModelProvider.notifier).loadProduct();
    final loadProductList = ref.watch(productViewModelProvider);
    final cart = ref.watch(cartViewModelProvider);

    final cartList = loadProductList
        .where((item) => cart.any((c) => item.id == c.pid))
        .toList();

    if (!context.mounted) {
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ProductListScreen(
          title: 'My Cart',
          isCart: true,
          products: cartList,
        ),
      ),
    );
  }

  List<Product> giftListItems() {
    ref.read(productViewModelProvider.notifier).loadProduct();
    ref.read(wishViewModelProvider.notifier).loadGifts();
    final loadProductList = ref.watch(productViewModelProvider);
    final loasWishList = ref.watch(wishViewModelProvider);
    final wishlist = loadProductList
        .where((item) => loasWishList.any((c) => item.id == c.pid))
        .toList();
    return wishlist;
  }

  @override
  Widget build(BuildContext context) {
    final cateList = ref.watch(categoryViewModelProvider);

    Widget activePage = CategoriesScreen(cateList: cateList);
    String activePageTitle = 'Categories';
    if (_selectedIndex == 1) {
      activePage = ProductListScreen(isWish: true, products: giftListItems());
      activePageTitle = 'Wish List';
    }

    return Scaffold(
      appBar: AppBar(
        title: Platform.isIOS
            ? Align(
                alignment: Alignment.centerLeft,
                child: Text(activePageTitle),
              )
            : Text(activePageTitle),
        actions: [
          IconButton(
            onPressed: () {
              _cartItem(context);
            },
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.5, end: 1).animate(animation),
                  child: child,
                );
              },
              child: Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wish List',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
