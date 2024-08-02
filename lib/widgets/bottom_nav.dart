import 'package:ecommerce/screens/Cart.dart';
import 'package:ecommerce/screens/Details.dart';
import 'package:ecommerce/screens/Favorite.dart';
import 'package:ecommerce/screens/Home.dart';

import 'package:ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';

import '../screens/profiile.dart';
import '../screens/trending.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int cuttentIndex = 2;
  List screens =[
    TrendingPage(),
    FavoriteScreen(),
    HomeScreen(),
    CartScreen(),
   ProfileScreen(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            cuttentIndex = 2;

          });
        },
        shape: CircleBorder(),
        backgroundColor: kprimaryColor,
        child: const Icon(Icons.home_outlined,color: Colors.white,size: 35,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: 60,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  cuttentIndex= 0;
                });
              },
              icon: Icon(Icons.trending_up_outlined,
                  size: 30,
                  color:
                      cuttentIndex == 0 ? kprimaryColor : Colors.grey.shade400),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  cuttentIndex= 1;
                });
              },
              icon: Icon(Icons.favorite_border,
                  size: 30,
                  color:
                      cuttentIndex == 1 ? kprimaryColor : Colors.grey.shade400),
            ),
            const SizedBox(
              width: 15,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  cuttentIndex= 3;
                });
              },
              icon: Icon(Icons.shopping_cart_outlined,
                  size: 30,
                  color:
                      cuttentIndex == 3 ? kprimaryColor : Colors.grey.shade400),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  cuttentIndex= 4;
                });
              },
              icon: Icon(Icons.person,
                  size: 30,
                  color:
                      cuttentIndex == 4 ? kprimaryColor : Colors.grey.shade400),
            ),
          ],
        ),
      ),
      body: screens[cuttentIndex],
    );
  }
}
