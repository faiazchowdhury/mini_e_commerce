import 'package:flutter/material.dart';
import 'package:mini_e_commerce/Constant.dart';
import 'package:mini_e_commerce/Home_Page/Drawer.dart';
import 'package:mini_e_commerce/Home_Page/HomePageProvider.dart';
import 'package:mini_e_commerce/Model/ProductModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<StatefulWidget> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final cartProvider = Homepageprovider();
  late SharedPreferences prefs;

  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: lightColor1.withOpacity(0.5),
        title: const Text('My Cart'),
      ),
      drawer: MyDrawer(),
      body: FutureBuilder(
          future: cartProvider.getProduct(),
          builder: (context, res) {
            return cartProvider.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int j = 0; j < res.data!.length; j++)
                          Visibility(
                            visible:
                                prefs.getInt("cart ${res.data![j].id}") != null,
                            child: Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(10),
                              width: 1000,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: Colors.black)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Column(
                                        children: [
                                          Image.network(
                                            res.data![j].image,
                                            height: 100,
                                          ),
                                          Text(
                                            "\$${res.data![j].price}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )),
                                  Expanded(flex: 1, child: Container()),
                                  Expanded(
                                      flex: 15,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            res.data![j].title,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            res.data![j].description,
                                            maxLines: 3,
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: TextButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(lightColor1
                                                                    .withOpacity(
                                                                        0.2)),
                                                      ),
                                                      onPressed: () {
                                                        if (prefs.getInt(
                                                                "cart ${res.data![j].id}") ==
                                                            1) {
                                                          prefs.remove(
                                                              "cart ${res.data![j].id}");
                                                        } else {
                                                          prefs.setInt(
                                                              "cart ${res.data![j].id}",
                                                              prefs.getInt(
                                                                      "cart ${res.data![j].id}")! -
                                                                  1);
                                                        }
                                                        setState(() {});
                                                      },
                                                      child:
                                                          Icon(Icons.remove))),
                                              Expanded(
                                                  child: Center(
                                                      child: Text(
                                                "${prefs.getInt("cart ${res.data![j].id}")}",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))),
                                              Expanded(
                                                  child: TextButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(lightColor1
                                                                    .withOpacity(
                                                                        0.2)),
                                                      ),
                                                      onPressed: () {
                                                        prefs.setInt(
                                                            "cart ${res.data![j].id}",
                                                            prefs.getInt(
                                                                    "cart ${res.data![j].id}")! +
                                                                1);
                                                        setState(() {});
                                                      },
                                                      child: Icon(Icons.add))),
                                            ],
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  );
          }),
    );
  }

  Future<void> getPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
}
