import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Registrationprovider with ChangeNotifier{
  String _userName="";
  String _email= '';
  String _pass='';
  bool _isLoading=false;
  String _res='';
  int _statusCode=0;

  String get username=> _userName;
  String get email=> _email;
  String get pass=> _pass;
  bool get isLoading=> _isLoading;
  String get res=> _res;
  int get statusCode=> _statusCode;

  void setEmail(email){
    _email=email;
    notifyListeners();
  }

  void setUserName(userName){
    _userName=userName;
    notifyListeners();
  }

  void setPass(pass){
    _pass=pass;
    notifyListeners();
  }

  Future<void> regPressed() async {
    _isLoading=true;
    notifyListeners();
    print(_email);
    var response = await http.post(Uri.parse("https://fakestoreapi.com/users"),body: json.encode({
      "id":600,
      "username": _userName,
      "password": _pass,
      "email":_email
    },),
    headers: {
                "Content-Type": "application/json",
                "Accept": "application/json, text/plain, */*"
              }
    );

    print (response.body);
    _isLoading=false;
    _statusCode=response.statusCode;
    _res=response.body;
    Fluttertoast.showToast(msg: response.body);
    notifyListeners();
  }

}