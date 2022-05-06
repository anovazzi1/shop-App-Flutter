import 'package:flutter/material.dart';
import 'package:shop_app_flutter/models/product.dart';
import '../providers/products_provider.dart';

import '../widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool favoritesFilter;
  const ProductsGrid(this.favoritesFilter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        favoritesFilter ? productsData.Favorites : productsData.items;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(),
      ),
      itemCount: products.length,
      padding: const EdgeInsets.all(10),
    );
  }
}
