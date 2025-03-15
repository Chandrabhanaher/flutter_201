import 'package:flutter_201/models/caregory.dart';
import 'package:flutter_201/models/product.dart';
import 'package:flutter_201/viewmodel/cart_viewmodel.dart';
import 'package:flutter_201/viewmodel/category_viewmodel.dart';
import 'package:flutter_201/viewmodel/product_viewmodel.dart';
import 'package:flutter_201/viewmodel/wish_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryViewModelProvider =
    StateNotifierProvider<CategoryViewModel, AsyncValue<List<Category>>>(
        (ref) => CategoryViewModel());

final productViewModelProvider =
    StateNotifierProvider<ProductViewModel, List<Product>>(
        (ref) => ProductViewModel());

final cartViewModelProvider =
    StateNotifierProvider<CartViewmodel, List<Cart>>((ref) => CartViewmodel());

final wishViewModelProvider =
    StateNotifierProvider<WishViewmodel, List<WishItem>>(
        (ref) => WishViewmodel());
