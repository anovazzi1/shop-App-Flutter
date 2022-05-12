import 'package:flutter/material.dart';
import 'dart:math';
import '../providers/orders.dart' as Op;

class OrderItem extends StatefulWidget {
  const OrderItem({required this.orderItem, Key? key}) : super(key: key);
  final Op.OrderItem orderItem;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text("\$${widget.orderItem.ammount}"),
            subtitle: Text(widget.orderItem.time.toString()),
            trailing: IconButton(
              icon: const Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.orderItem.products.length * 20 + 100, 180),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.orderItem.products[index].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                          '\$${widget.orderItem.products[index].quantity} x \$${widget.orderItem.products[index].price}')
                    ],
                  );
                },
                itemCount: widget.orderItem.products.length,
              ),
            )
        ],
      ),
      margin: const EdgeInsets.all(8),
    );
  }
}
