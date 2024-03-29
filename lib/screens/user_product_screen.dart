import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/screens/edit_product_screen.dart';
import 'package:shop_app_flutter/widgets/app_drawer.dart';
import 'package:shop_app_flutter/widgets/user_product_item.dart';
import '../providers/products_provider.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);

  static const route = "/UserProductsScreen";

  Future<void> _refresh(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.route);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
          future: _refresh(context),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () {
                    print(snapshot.connectionState);
                    return _refresh(context);
                  },
                  child: Consumer<Products>(
                    builder: (ctx, productsData, _) {
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return UserProductItem(
                                title: productsData.items[index].title,
                                imageUrl: productsData.items[index].imageUrl,
                                id: productsData.items[index].id);
                          },
                          itemCount: productsData.items.length,
                        ),
                      );
                    },
                  ),
                )),
      drawer: AppDrawer(),
    );
  }
}
