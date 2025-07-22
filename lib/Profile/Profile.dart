import 'package:flutter/material.dart';
import 'package:mini_e_commerce/Constant.dart';
import 'package:mini_e_commerce/Home_Page/Drawer.dart';
import 'package:mini_e_commerce/Profile/ProfileProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final profileProvider = Profileprovider();
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
        title: const Text('Profile'),
      ),
      drawer: const MyDrawer(),
      body: FutureBuilder(
          future: profileProvider.getUser(),
          builder: (context, res) {
            return profileProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          for (int i = 0; i < res.data!.length; i++)
                            Visibility(
                                visible: res.data![i].username ==
                                    prefs.getString("email"),
                                child: Column(children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(200))),
                                      child: Icon(
                                        Icons.person,
                                        size: 100,
                                      )),
                                  Text(
                                    "${res.data![i].name.firstname} ${res.data![i].name.lastname}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Divider(
                                    height: 50,
                                    color: Colors.black,
                                    thickness: 1,
                                  ),
                                  rowItem("Username", res.data![i].username),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  rowItem("Email", res.data![i].email),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  rowItem("Phone", res.data![i].phone),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  rowItem("Address", "${res.data![i].address.number}, ${res.data![i].address.street}, ${res.data![i].address.city}, ${res.data![i].address.zipcode}"),
                                ]))
                        ],
                      ),
                    ),
                  );
          }),
    );
  }

  Widget rowItem(header, title) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Text(
              header,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> getPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
}
