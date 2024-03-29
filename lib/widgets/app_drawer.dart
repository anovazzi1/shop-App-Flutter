import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/auth.dart';
import 'package:shop_app_flutter/screens/orders_screen.dart';
import 'package:shop_app_flutter/screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("TEST"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("shop"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: Text("payment"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.route);
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("your products"),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.route),
          ),
          Divider(),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Exit"),
              onTap: () {
                Navigator.of(context).pop();
                Provider.of<Auth>(context, listen: false).logout();
                Navigator.of(context).pushReplacementNamed('/');
              })
        ],
      ),
    );
  }
}
