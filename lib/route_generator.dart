import 'package:flutter/material.dart';
import '/screens/product_detail_screen.dart';
import '/screens/products_overview_screen.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings)
  {
    final args = settings.arguments;
    final name = settings.name;
    switch(settings.name)
    {
      case '/':
        return MaterialPageRoute(builder: (context)=>ProductsOverviewScreen());
      case ProductDetailScreen.productDetailRoute:
        args as String;
        return MaterialPageRoute(builder: (context)=>ProductDetailScreen(args));
      default:
        return MaterialPageRoute(builder: (context)=>ErrorRoute());
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
          "an error occurred, please try again",textScaleFactor: 3,
        ),
      ),
    );
  }
}

