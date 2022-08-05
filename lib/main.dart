import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/auth.dart';
import 'package:shop_app_flutter/providers/card.dart';
import 'package:shop_app_flutter/providers/orders.dart';
import 'package:shop_app_flutter/route_generator.dart';
import 'package:shop_app_flutter/screens/auth_screen.dart';
import 'package:shop_app_flutter/screens/products_overview_screen.dart';
import './theme.dart';
import 'providers/products_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
              create: (ctx) => Products('', []),
              update: (ctx, auth, previousProducts) => Products(auth.getToken(),
                  previousProducts == null ? [] : previousProducts.items)),
          ChangeNotifierProvider(create: (context) => Cart()),
          ChangeNotifierProxyProvider<Auth, Orders>(
              create: (ctx) => Orders('', []),
              update: (ctx, auth, previousOrders) => Orders(auth.getToken(),
                  previousOrders == null ? [] : previousOrders.orders)),
        ],
        child: Consumer<Auth>(
          builder: (context, auth, _) {
            return MaterialApp(
              title: 'MyShop',
              theme: myTheme,
              onGenerateRoute: RouteGenerator.generateRoute,
              debugShowCheckedModeBanner: false,
              home: auth.isLogged() ? ProductsOverviewScreen() : AuthScreen(),
            );
          },
        ));
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: Center(
        child: const Text('Let\'s build a shop!'),
      ),
    );
  }
}
