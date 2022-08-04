import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:shop_app_flutter/api_key.dart';
import '../models/exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  Future<void> signup(String email, String password) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${ApiKey.key}");
    try {
      var response = await post(url,
          body: jsonEncode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
      if (response.statusCode >= 400) {
        throw HttpException(jsonDecode(response.body)['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signIn(String email, String password) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${ApiKey.key}");
    try {
      var response = await post(url,
          body: jsonEncode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
      final responseData = jsonDecode(response.body);
      if (response.statusCode >= 400) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  String? getToken() {
    if (_expiryDate != Null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  bool isLogged() {
    print(_token);
    return _token != null;
  }
}
