import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_201/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductViewModel extends StateNotifier<List<Product>> {
  ProductViewModel() : super([]);
  Future<void> loadProduct() async {
    try {
      final String response =
          await rootBundle.loadString('assets/product_items.json');
      final List<dynamic> data = json.decode(response);
      final product = data.map((item) => Product.fromJson(item)).toList();
      state = product;
    } catch (e) {
      state = [];
    }
  }
}
