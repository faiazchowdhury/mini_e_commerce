import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mini_e_commerce/Model/ProfileModel.dart';

class Profileprovider with ChangeNotifier{
  bool _isLoading=false;

  bool get isLoading => _isLoading;

  Future<List<ProfileModel>> getUser() async {
    _isLoading=true;
    notifyListeners();
    var response =
        await http.get(Uri.parse("https://fakestoreapi.com/users"),
            headers: {
          "Content-Type": "application/json",
          "Accept": "application/json, text/plain, */*"
        });
        print(json.decode(response.body));
    List<ProfileModel> res= profileModelFromJson(response.body);
    _isLoading=false;
    notifyListeners();
    return res;
  }
}