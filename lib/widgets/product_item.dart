import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String url;
  final String title;
  final String id;
  const ProductItem(this.id, this.title, this.url, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.network(
          url,
          fit: BoxFit.fill,
        ),
        footer: GridTileBar(
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black38,
          leading: Icon(Icons.favorite_outline_outlined),
          trailing: Icon(Icons.shopping_cart_outlined),
        ),
      ),
    );
  }
}
