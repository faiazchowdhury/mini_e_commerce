import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mini_e_commerce/Model/ProductModel.dart';
import 'package:http/http.dart' as http;


class Homepageprovider with ChangeNotifier{
  bool _isLoading=false;

  bool get isLoading => _isLoading;

  Future<List<ProductModel>> getProduct() async {
    _isLoading=true;
    notifyListeners();
    var response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"),
            headers: {
          "Content-Type": "application/json",
          "Accept": "application/json, text/plain, */*"
        });
        print(json.decode(response.body));
    List<ProductModel> res= productModelFromJson(response.body);
    _isLoading=false;
    notifyListeners();
    return res;
  }
}