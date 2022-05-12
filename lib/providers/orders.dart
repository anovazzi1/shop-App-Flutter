import 'package:flutter/material.dart';
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

  void addOrder(List<CardItem> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            ammount: total,
            products: cartProducts,
            time: DateTime.now()));
    notifyListeners();
  }
}
