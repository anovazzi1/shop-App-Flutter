import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id, title, description, imageUrl;
  final double price;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.price,
      this.isFavorite = false});

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final response = await http.patch(
          Uri.parse(
              "https://shoppappflutter-4318e-default-rtdb.firebaseio.com/products/$id.json"),
          body: json.encode({'isFavorite': isFavorite}));
      if (response.statusCode > 200) {
        throw Error();
      }
    } catch (error) {
      isFavorite = oldStatus;
    }
  }
}
