import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  String _email = '';
  String _pass = '';
  bool _isLoading = false;
  String _res = '';
  int _statusCode = 0;

  String get email => _email;
  String get pass => _pass;
  bool get isLoading => _isLoading;
  String get res => _res;
  int get statusCode => _statusCode;

  void setEmail(email) {
    _email = email;
    notifyListeners();
  }

  void setPass(pass) {
    _pass = pass;
    notifyListeners();
  }

  Future<void> loginPressed() async {
    _isLoading = true;
    notifyListeners();
    print(_email);
    var response =
        await http.post(Uri.parse("https://fakestoreapi.com/auth/login"),
            body: json.encode(
              {"username": _email, "password": _pass},
            ),
            headers: {
          "Content-Type": "application/json",
          "Accept": "application/json, text/plain, */*"
        });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(response.body);
    _isLoading = false;
    _statusCode = response.statusCode;
    _res = response.body;
    if (_statusCode == 200) {
      prefs.setString('token', jsonDecode(response.body)['token']);
    } else {
      Fluttertoast.showToast(msg: response.body);
    }
    notifyListeners();
  }
}
