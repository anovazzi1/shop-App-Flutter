import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String productDetailRoute = "/productDetailScreen";
  final String id;
  const ProductDetailScreen(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoadedProduct =
        Provider.of<Products>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(LoadedProduct.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                child: Image.network(
                  LoadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                LoadedProduct.title,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text('\$${LoadedProduct.price}'),
              SizedBox(
                height: 20,
              ),
              Text(
                LoadedProduct.description,
                softWrap: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
