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

  OrderItem({
    required this.id,
    required this.ammount,
    required this.products,
    required this.time,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String? token;
  Orders(this.token, this._orders);

  List<OrderItem> get orders => [..._orders];

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        "https://shoppappflutter-4318e-default-rtdb.firebaseio.com/orders.json?auth=$token");
    final response = await get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    print(extractedData);
    extractedData.forEach((orderId, value) {
      loadedOrders.add(OrderItem(
          id: orderId,
          ammount: value['amount'],
          products: (value['products'] as List<dynamic>)
              .map((e) => CardItem(
                  id: e['id'],
                  title: e['title'],
                  quantity: e['quantity'],
                  price: e['price']))
              .toList(),
          time: DateTime.parse(value['dateTime'])));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

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
