import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../providers/card.dart';

class OrderItem {
  final String id;
  final double ammount;
  final List<CardItem> products;
  final DateTime time;

  OrderItem(
      {required this.id,
      required this.ammount,
      required this.products,
      required this.time});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];

  Future<void> addOrder(List<CardItem> cartProducts, double total) async {
    final url = Uri.parse(
        "https://shoppappflutter-4318e-default-rtdb.firebaseio.com/orders.json");
    final now = DateTime.now();
    try {
      final response = await post(
        url,
        body: jsonEncode(
          {
            "amount": total,
            "dateTime": now.toIso8601String(),
            "products": cartProducts
                .map((cardItem) => {
                      "id": cardItem.id,
                      "title": cardItem.title,
                      "quantity": cardItem.quantity,
                      "price": cardItem.price
                    })
                .toList()
          },
        ),
      );
      _orders.insert(
          0,
          OrderItem(
              id: json.decode(response.body)['name'],
              ammount: total,
              products: cartProducts,
              time: now));
      notifyListeners();
    } catch (error) {
      return;
    }
  }
}
