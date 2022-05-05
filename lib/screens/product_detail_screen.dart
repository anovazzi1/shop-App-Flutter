import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String productDetailRoute = "/productDetailScreen";
  final String id;
  const ProductDetailScreen(this.id,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoadedProduct = Provider.of<Products>(context,listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(LoadedProduct.title),
      ),
    );
  }
}
