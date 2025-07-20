import 'package:flutter/material.dart';
import 'package:mini_e_commerce/Constant.dart';
import 'package:mini_e_commerce/Home_Page/Drawer.dart';

class Cart extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CartState();
}

class _CartState extends State<Cart>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  lightColor1,
        title: const Text('My Cart'),
      ),
      drawer:  MyDrawer(),
      body: Container(),
    );
  }
}