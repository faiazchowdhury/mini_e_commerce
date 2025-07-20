import 'package:flutter/material.dart';
import 'package:mini_e_commerce/Constant.dart';
import 'package:mini_e_commerce/Home_Page/Drawer.dart';
import 'package:mini_e_commerce/Home_Page/HomePageProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeProvider = Homepageprovider();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  lightColor1,
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
                        children: [
                          for (int i = 0; i < res.data!.length; i++)
                            Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(10),
                              width: 1000,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: Colors.black)
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      children: [
                                        Image.network(res.data![i].image,
                                                                          height: 100,
                                                                          ),
                                        Text("\$${res.data![i].price}",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )),
                                  Expanded(
                                    flex: 1,
                                    child: Container()),
                                  Expanded(
                                    flex: 15,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(res.data![i].title,
                                        style: TextStyle(fontSize: 15,
                                        fontWeight: FontWeight.bold
                                        ),
                                        ),
                                        SizedBox(height: 5,),
                                        Text(res.data![i].description,
                                        style: TextStyle( fontSize: 10),
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
}
