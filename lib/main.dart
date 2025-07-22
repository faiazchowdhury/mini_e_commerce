import 'package:flutter/material.dart';
import 'package:mini_e_commerce/Constant.dart';
import 'package:mini_e_commerce/Home_Page/HomePage.dart';
import 'package:mini_e_commerce/Home_Page/HomePageProvider.dart';
import 'package:mini_e_commerce/Login/LoginProvide.dart';
import 'package:mini_e_commerce/Login/login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => Homepageprovider()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode getTheme()=> _themeMode; 

  Future<void> changeTheme(int i) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (i == 0) {
        if (prefs.getBool("theme") == null) {
          _themeMode = ThemeMode.light;
          prefs.setBool("theme", true);
        } else if (prefs.getBool("theme")!) {
          _themeMode = ThemeMode.light;
          prefs.setBool("theme", true);
        } else {
          _themeMode = ThemeMode.dark;
          prefs.setBool("theme", false);
        }
      } else {
        if (prefs.getBool("theme") == null) {
          _themeMode = ThemeMode.dark;
          prefs.setBool("theme", false);
        } else if (prefs.getBool("theme") == true) {
          _themeMode = ThemeMode.dark;
          prefs.setBool("theme", false);
        } else {
          _themeMode = ThemeMode.light;
          prefs.setBool("theme", true);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
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
    return Scaffold(

      body: Center(
        child: Container(
          child: Text("Hello! Lets Get Started!",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
          )
        ),
      ),
    );
  }

  Future<void> getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    MyApp.of(context).changeTheme(0);
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
