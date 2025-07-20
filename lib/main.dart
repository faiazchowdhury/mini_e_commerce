import 'package:flutter/material.dart';
import 'package:mini_e_commerce/Constant.dart';
import 'package:mini_e_commerce/Home_Page/HomePage.dart';
import 'package:mini_e_commerce/Home_Page/HomePageProvider.dart';
import 'package:mini_e_commerce/Login/LoginProvide.dart';
import 'package:mini_e_commerce/Login/login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SharedPreferences prefs;
  @override
  initState() {
    getPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => Homepageprovider()),
    ], child: Container());
  }

  Future<void> getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => LoginProvider()),
                    ChangeNotifierProvider(create: (_) => Homepageprovider()),
                  ],
                  child: prefs.getString("token") != null
                      ? HomePage()
                      : LoginPage(),
                )),
        (boo) => false);
  }
}
