import 'package:flutter/material.dart';
import '../models/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchProducts() async {
    var url = Uri.parse(
        "https://shoppappflutter-4318e-default-rtdb.firebaseio.com/products.json");
    try {
      final List<Product> loadedProducts = [];
      final response = await http.get(url);
      final Data = json.decode(response.body) as Map<String, dynamic>;
      Data.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            price: prodData['price'],
            isFavorite: prodData['isFavorite']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  List<Product> get Favorites {
    return _items.where((element) => element.isFavorite == true).toList();
  }

  Product findById(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  Future<void> addProduct(Product product) {
    final url = Uri.parse(
        "https://shoppappflutter-4318e-default-rtdb.firebaseio.com/products.json");
    return http
        .post(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'price': product.price,
              'imageUrl': product.imageUrl,
              'isFavorite': product.isFavorite,
              'id': DateTime.now().toString()
            }))
        .then((response) {
      final newProduct = Product(
          title: product.title,
          price: product.price,
          description: product.description,
          imageUrl: product.imageUrl,
          id: json.decode(response.body)['name']);
      _items.add(newProduct);

      notifyListeners();
    }).catchError((error) {
      throw error;
    });
  }

  void updateProduct(String id, Product updatedProduct) {
    var newProductIndex = _items.indexWhere((element) => element.id == id);
    _items[newProductIndex] = updatedProduct;
    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
