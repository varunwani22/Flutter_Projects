import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_providers.dart';
import 'package:shop_app/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  ProductGrid(this.showFavs);

  final bool showFavs;

//Only this method will rebuild if data of product has change.
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoirteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        //ChangeNotifierProvider.value - .value is use when we need to change single product of list insted of create method
        value: products[index],
        child: ProductItem(),
      ),
    );
  }
}
