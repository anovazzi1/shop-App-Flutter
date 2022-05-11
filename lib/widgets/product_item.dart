import 'package:flutter/material.dart';
import 'package:shop_app_flutter/providers/card.dart';
import '../models/product.dart';
import 'package:shop_app_flutter/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
                ProductDetailScreen.productDetailRoute,
                arguments: item.id);
          },
          enableFeedback: null,
          child: Image.network(
            item.imageUrl,
            fit: BoxFit.fill,
          ),
        ),
        footer: GridTileBar(
          title: Text(
            item.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black38,
          leading: IconButton(
            icon:
                Icon(item.isFavorite ? Icons.favorite : Icons.favorite_outline),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              item.toggleFavoriteStatus();
            },
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              cart.addItem(item.id, item.price, item.title);
            },
          ),
        ),
      ),
    );
  }
}
