import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_201/models/caregory.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryViewModel extends StateNotifier<AsyncValue<List<Category>>> {
  CategoryViewModel() : super(const AsyncValue.loading()) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      // Load JSON data from assets
      final String response =
          await rootBundle.loadString('assets/categories.json');
      final List<dynamic> data = json.decode(response);
      // Map the JSON to Category objects
      final categories = data.map((item) => Category.fromJson(item)).toList();
      state = AsyncValue.data(categories);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
