import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price,
      Key? key})
      : super(key: key);
  final String id, title;
  final double price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(child: Text('\$$price')),
          ),
          title: Text(title),
          subtitle: Text('Total: \$${price * quantity}'),
          trailing: Text('x $quantity'),
        ),
      ),
    );
  }
}