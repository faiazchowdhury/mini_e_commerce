import 'package:flutter/material.dart';
import 'package:mini_e_commerce/Cart_Page/Cart.dart';
import 'package:mini_e_commerce/Constant.dart';
import 'package:mini_e_commerce/Favorite/Favorite.dart';
import 'package:mini_e_commerce/Home_Page/HomePage.dart';
import 'package:mini_e_commerce/Home_Page/TextIconButton.dart';
import 'package:mini_e_commerce/Login/login_page.dart';
import 'package:mini_e_commerce/Profile/Profile.dart';
import 'package:mini_e_commerce/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextIconButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => HomePage(),
                    ),
                  ),
                  icon: Icons.home,
                  label: 'Home Screen',
                ),
                TextIconButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => Cart(),
                    ),
                  ),
                  icon: Icons.shopping_cart,
                  label: 'My Cart',
                ),
                TextIconButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => Favorite(),
                    ),
                  ),
                  icon: Icons.wallet_giftcard,
                  label: 'Favorite',
                ),
                TextIconButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => Profile(),
                    ),
                  ),
                  icon: Icons.person,
                  label: 'Profile',
                ),
                SizedBox(
                  height: 10,
                ),
                ToggleSwitch(
                  initialLabelIndex:
                      MyApp.of(context).getTheme() == ThemeMode.light ? 0 : 1,
                  minWidth: 170,
                  onToggle: (index) => MyApp.of(context).changeTheme(1),
                  activeBgColors: [
                    [lightColor1.withOpacity(0.8)],
                    [lightColor1.withOpacity(0.8)]
                  ],
                  labels: ["Light Mode", "Dark Mode"],
                ),
                const Divider(
                  height: 50,
                  color: Colors.black,
                  thickness: 1,
                ),
                TextIconButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => LoginPage(),
                      ),
                      (route) => false,
                    );
                  },
                  icon: Icons.logout,
                  label: 'Log Out',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildHeader() => InkWell(
      child: Container(
        padding: const EdgeInsets.only(
          top: 40,
          bottom: 20,
        ),
        color: const Color(0xff3444B5),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/profile2.webp'),
            ),
            SizedBox(height: 15),
            Text(
              'Max Alegri',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, color: Colors.white),
                Text(
                  'New York',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
