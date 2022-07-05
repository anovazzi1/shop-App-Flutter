import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:shop_app_flutter/api_key.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  Future<void> signup(String email, String password) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${ApiKey.key}");
    var response = await post(url,
        body: jsonEncode({
          "email": email,
          "password": password,
          "returnSecureToken": true,
        }));
    print(json.decode(response.body));
  }

  Future<void> signIn(String email, String password) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$ApiKey.key");
    var response = await post(url,
        body: jsonEncode({
          "email": email,
          "password": password,
          "returnSecureToken": true,
        }));
    print(json.decode(response.body));
  }
}
