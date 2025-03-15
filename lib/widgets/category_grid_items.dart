import 'package:flutter/material.dart';
import 'package:flutter_201/models/caregory.dart';

class CategoryGridItems extends StatelessWidget {
  const CategoryGridItems(
      {super.key, required this.category, required this.onSelectCategory});

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.shade100,
              Colors.purple.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}
