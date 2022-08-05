import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CardItem {
  final String id;
  final String title;
  int quantity;
  final double price;

  CardItem(
      {required this.id,
      required this.title,
      this.quantity = 1,
      required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CardItem> _items = {};

  get items => {..._items};

  int get itemCount {
    return _items.length;
  }

  void addItem(
    String id,
    double price,
    String title,
  ) {
    if (_items.containsKey(id)) {
      _items.update(
          id,
          (value) => CardItem(
              id: value.id,
              title: value.title,
              price: value.price,
              quantity: value.quantity + 1));
    } else {
      _items.putIfAbsent(
          id,
          () => CardItem(
              id: DateTime.now().toString(), title: title, price: price));
    }
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    _items[id]!.quantity > 1 ? _items[id]!.quantity -= 1 : _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
