import 'package:flutter_201/db/local_db.dart';
import 'package:flutter_201/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishViewmodel extends StateNotifier<List<WishItem>> {
  WishViewmodel() : super([]);

  Future<void> loadGifts() async {
    final products = await LocalDB.instance.getAllFavItems();
    final cart = products.map((item) => WishItem(pid: item['pid'])).toList();
    state = cart;
  }

  bool isWishItam(Product proudct) {
    final wishItem = state.where((item) => proudct.id == item.pid).toList();
    if (wishItem.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool addWishItem(WishItem wishItem) {
    final wishData = state.where((item) => item.pid == wishItem.pid).toList();
    if (wishData.isNotEmpty) {
      state = state.where((m) => m.pid != wishItem.pid).toList();
      removeItem(wishItem.pid);
      return false;
    } else {
      LocalDB.instance.addWish({'pid': wishItem.pid});
      state = [wishItem, ...state];
      return true;
    }
  }

  void removeItem(String pId) {
    LocalDB.instance.deleteFavItem(pId);
    state = state.where((i) => i.pid != pId).toList();
  }
}
