import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mini_e_commerce/Constant.dart';
import 'package:mini_e_commerce/Home_Page/Drawer.dart';
import 'package:mini_e_commerce/Home_Page/HomePageProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeProvider = Homepageprovider();
  late final SharedPreferences prefs;

  @override
  initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: lightColor1.withOpacity(0.5),
          title: const Text('Home Screen'),
        ),
        drawer: const MyDrawer(),
        body: SafeArea(
          child: FutureBuilder(
              future: homeProvider.getProduct(),
              builder: (context, res) => homeProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < res.data!.length; i++)
                            Container(
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
                                            res.data![i].image,
                                            height: 100,
                                          ),
                                          Text(
                                            "\$${res.data![i].price}",
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
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 10,
                                                child: Text(
                                                  res.data![i].title,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: GestureDetector(
                                                    onTap: () {
                                                      if (prefs.getBool(
                                                              "${res.data![i].id}") ==
                                                          null) {
                                                        prefs.setBool(
                                                            '${res.data![i].id}',
                                                            true);
                                                      } else {
                                                        prefs.remove(
                                                            '${res.data![i].id}');
                                                      }
                                                      setState(() {});
                                                    },
                                                    child: Icon(
                                                      Icons.favorite,
                                                      color: prefs.getBool(
                                                                  "${res.data![i].id}") !=
                                                              null
                                                          ? Colors.red
                                                          : Colors.grey,
                                                    )),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            res.data![i].description,
                                            maxLines: 3,
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                          TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        lightColor1
                                                            .withOpacity(0.2)),
                                              ),
                                              onPressed: () {
                                                if (prefs.getInt(
                                                        "cart ${res.data![i].id}") !=
                                                    null) {
                                                  prefs.setInt(
                                                      "cart ${res.data![i].id}",
                                                      prefs.getInt(
                                                              "cart ${res.data![i].id}")! +
                                                          1);
                                                } else {
                                                  prefs.setInt(
                                                      "cart ${res.data![i].id}",
                                                      1);
                                                }
                                                Fluttertoast.showToast(msg: "Item Added to Cart");
                                              },
                                              child: Container(
                                                  width: 500,
                                                  child: Center(
                                                      child:
                                                          Text("Add to Cart"))))
                                        ],
                                      )),
                                ],
                              ),
                            )
                        ],
                      ),
                    )),
        ));
  }

  Future<void> getPref() async {
    prefs = await SharedPreferences.getInstance();
  }
}
