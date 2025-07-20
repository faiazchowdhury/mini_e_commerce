import 'package:flutter/material.dart';
import 'package:mini_e_commerce/Cart_Page/Cart.dart';
import 'package:mini_e_commerce/Home_Page/HomePage.dart';
import 'package:mini_e_commerce/Home_Page/TextIconButton.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 50,),
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
                  onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => Cart(),
                    ),),
                  icon: Icons.shopping_cart,
                  label: 'My Cart',
                ),
                const TextIconButton(
                  icon: Icons.wallet_giftcard,
                  label: 'Favorite',
                ),
                const Divider(
                  height: 50,
                  color: Colors.black,
                  thickness: 1,
                ),
                TextIconButton(
                  onPressed: () {
                    Scaffold.of(context).closeDrawer();
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