import 'package:flutter/material.dart';
import 'package:meals_app/widgets/category_item.dart';
import 'package:meals_app/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        childAspectRatio: 2.5 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children: DUMMY_CATEGORIES
          .map(
            (data) => CategoryItem(
              id: data.id,
              title: data.title,
              color: data.color,
            ),
          )
          .toList(),
    );
  }
}
