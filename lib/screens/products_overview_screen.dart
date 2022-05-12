import 'package:flutter/material.dart';
import 'package:shop_app_flutter/providers/card.dart';
import 'package:shop_app_flutter/screens/cart_screen.dart';
import 'package:shop_app_flutter/widgets/app_drawer.dart';
import 'package:shop_app_flutter/widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../widgets/badge.dart';

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
          ),
          Consumer<Cart>(
            builder: (context, cartData, ch) => Badge(
                child: ch!,
                value: cartData.itemCount.toString(),
                color: Theme.of(context).primaryColor),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.route);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
