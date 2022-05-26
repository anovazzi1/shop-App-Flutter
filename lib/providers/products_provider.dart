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

  Future<void> updateProduct(String id, Product updatedProduct) async {
    var newProductIndex = _items.indexWhere((element) => element.id == id);
    final url = Uri.parse(
        "https://shoppappflutter-4318e-default-rtdb.firebaseio.com/products/$id.json");
    try {
      if (newProductIndex > 0) {
        await http.patch(url,
            body: json.encode({
              'title': updatedProduct.title,
              'description': updatedProduct.description,
              'imageUrl': updatedProduct.imageUrl,
              'price': updatedProduct.price
            }));

        _items[newProductIndex] = updatedProduct;
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }

  void deleteProduct(String id) {
    final url = Uri.parse(
        "https://shoppappflutter-4318e-default-rtdb.firebaseio.com/products/$id.json");
    http.delete(url);
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
