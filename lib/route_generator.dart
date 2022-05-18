import 'package:flutter/material.dart';
import 'package:shop_app_flutter/screens/cart_screen.dart';
import 'package:shop_app_flutter/screens/edit_product_screen.dart';
import 'package:shop_app_flutter/screens/orders_screen.dart';
import 'package:shop_app_flutter/screens/user_product_screen.dart';
import '/screens/product_detail_screen.dart';
import '/screens/products_overview_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final name = settings.name;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => ProductsOverviewScreen());
      case ProductDetailScreen.productDetailRoute:
        args as String;
        return MaterialPageRoute(
            builder: (context) => ProductDetailScreen(args));
      case CartScreen.route:
        return MaterialPageRoute(builder: (context) => CartScreen());
      case OrderScreen.route:
        return MaterialPageRoute(builder: (context) => OrderScreen());
      case UserProductsScreen.route:
        return MaterialPageRoute(builder: (context) => UserProductsScreen());
      case EditProductScreen.route:
        args as String?;
        return MaterialPageRoute(
            builder: (context) => EditProductScreen(
                  productId: args,
                ));
      default:
        return MaterialPageRoute(builder: (context) => ErrorRoute());
    }
  }
}

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "an error occurred, please try again",
          textScaleFactor: 3,
        ),
      ),
    );
  }
}
