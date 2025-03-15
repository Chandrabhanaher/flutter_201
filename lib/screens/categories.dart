import 'package:flutter/material.dart';
import 'package:flutter_201/models/caregory.dart';
import 'package:flutter_201/providers/providers.dart';
import 'package:flutter_201/screens/product_list.dart';
import 'package:flutter_201/widgets/category_grid_items.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key, required this.cateList});

  final AsyncValue<List<Category>> cateList;

  void _selectCategory(
      BuildContext context, Category category, WidgetRef ref) async {
    await ref.read(cartViewModelProvider.notifier).loadCart();
    await ref.read(productViewModelProvider.notifier).loadProduct();
    final loadProductList = ref.watch(productViewModelProvider);
    final availableList = loadProductList
        .where((item) => item.categories.contains(category.id))
        .toList();

    if (!context.mounted) {
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ProductListScreen(
          title: category.title,
          products: availableList,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return cateList.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (categories) => GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: categories
            .map(
              (elements) => CategoryGridItems(
                category: elements,
                onSelectCategory: () {
                  _selectCategory(context, elements, ref);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
