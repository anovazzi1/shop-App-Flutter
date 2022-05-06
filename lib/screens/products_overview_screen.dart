import 'package:flutter/material.dart';
import 'package:shop_app_flutter/widgets/products_grid.dart';

enum FilterValues { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("my Shop"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: (FilterValues selected) {
              setState(() {
                if (selected == FilterValues.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text("Only favorites"),
                  value: FilterValues.Favorites,
                ),
                const PopupMenuItem(
                  child: Text("Show all"),
                  value: FilterValues.All,
                )
              ];
            },
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
