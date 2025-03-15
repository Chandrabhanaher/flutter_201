import 'package:flutter_201/db/local_db.dart';
import 'package:flutter_201/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartViewmodel extends StateNotifier<List<Cart>> {
  CartViewmodel() : super([]);

  Future<void> loadCart() async {
    final products = await LocalDB.instance.getAllCartItems();
    final cart = products.map((item) => Cart(pid: item['pid'])).toList();
    state = cart;
  }

  bool addRemoveItem(Cart cart) {
    final cartItem = state.where((item) => item.pid == cart.pid).toList();
    if (cartItem.isNotEmpty) {
      removeItem(cart.pid);
      return false;
    } else {
      addToCart(cart);
      return true;
    }
  }

  void addToCart(Cart cart) async {
    await LocalDB.instance.addCart({'pid': cart.pid});
    state = [...state, cart];
  }

  void removeItem(String pId) async {
    await LocalDB.instance.deleteCartItem(pId);
    state = state.where((i) => i.pid != pId).toList();
  }

  void clearCart() {
    state = [];
  }
}
