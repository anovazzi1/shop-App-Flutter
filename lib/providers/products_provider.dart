import 'package:flutter/material.dart';
import '../models/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  final String userId;
  String? authToken;
  Products(this.authToken, this._items, this.userId);

  Future<void> fetchProducts([bool filterByUser = false]) async {
    final String filterString =
        filterByUser ? "orderBy=\"creatorId\"&equalTo=\"$userId\"" : "";
    var url = Uri.parse(
        "https://shoppappflutter-4318e-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString");
    try {
      final List<Product> loadedProducts = [];
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data == null) {
        return;
      }
      final favoritesUrl = Uri.parse(
          "https://shoppappflutter-4318e-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken");
      final favoriteResponse = await http.get(favoritesUrl);
      final favoriteData = json.decode(favoriteResponse.body);

      data.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            price: prodData['price'],
            isFavorite:
                favoriteData == null ? false : favoriteData[prodId] ?? false));
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
        "https://shoppappflutter-4318e-default-rtdb.firebaseio.com/products.json?auth=$authToken");
    return http
        .post(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'price': product.price,
              'imageUrl': product.imageUrl,
              'id': DateTime.now().toString(),
              'creatorId': userId,
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
        "https://shoppappflutter-4318e-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken");
    try {
      if (newProductIndex >= 0) {
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
        "https://shoppappflutter-4318e-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken");
    var productIndex = _items.indexWhere((element) => element.id == id);
    Product? removedProduct = _items[productIndex];
    http
        .delete(url)
        .then((response) => response.statusCode >= 400
            ? removedProduct = null
            : throw HttpException("could not delet product"))
        .catchError((error) {
      _items.insert(productIndex, removedProduct!);
    });
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
