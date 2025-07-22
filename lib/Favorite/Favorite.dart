import 'package:flutter/material.dart';
import 'package:mini_e_commerce/Constant.dart';
import 'package:mini_e_commerce/Home_Page/Drawer.dart';
import 'package:mini_e_commerce/Home_Page/HomePageProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<StatefulWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<Favorite> {
  final favoriteProvider = Homepageprovider();
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
          title: const Text('Favorite'),
        ),
        drawer: const MyDrawer(),
        body: SafeArea(
          child: FutureBuilder(
              future: favoriteProvider.getProduct(),
              builder: (context, res) => favoriteProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < res.data!.length; i++)
                          if(prefs.getBool("${res.data![i].id}")!=null)
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
                                                      print(prefs.getBool(
                                                          "${res.data![i].id}"));
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
                                          )
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
