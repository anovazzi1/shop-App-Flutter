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
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(LoadedProduct.title),
                background: Hero(
                  tag: LoadedProduct.id,
                  child: Image.network(
                    LoadedProduct.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 10,
                ),
                Text(
                  LoadedProduct.title,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  '\$${LoadedProduct.price}',
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  LoadedProduct.description,
                  softWrap: true,
                ),
                SizedBox(
                  height: 800,
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
