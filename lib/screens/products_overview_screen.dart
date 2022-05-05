import 'package:flutter/material.dart';
import 'package:shop_app_flutter/widgets/products_grid.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';

class ProductsOverviewScreen extends StatelessWidget {
  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("my Shop"),
        centerTitle: true,
      ),
      body: ProductsGrid(),
    );
  }
}
