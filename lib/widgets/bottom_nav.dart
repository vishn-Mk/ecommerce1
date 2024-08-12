import 'package:ecommerce/screens/Cart.dart';
import 'package:ecommerce/screens/Favorite.dart';
import 'package:ecommerce/screens/Home.dart';

import 'package:ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';

import '../screens/ChatBot.dart';
import '../screens/profiile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 2; // Set to 'Home' to open HomeScreen by default

  // Updated list of screens
  final List<Widget> screens = [
    ChatScreen(),
    FavoriteScreen(),
    HomeScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey.shade400,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: 'ChatBot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
// import 'package:ecommerce/screens/Cart.dart';
// import 'package:ecommerce/screens/Favorite.dart';
// import 'package:ecommerce/screens/Home.dart';
// import 'package:ecommerce/screens/profiile.dart';
// import 'package:ecommerce/screens/trending.dart';
// import 'package:ecommerce/utils/constants.dart';
// import 'package:flutter/material.dart';
//
// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});
//
//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> {
//   int currentIndex = 2;
//   final List<Widget> screens = [
//     TrendingPage(),
//     FavoriteScreen(),
//     HomeScreen(),
//     CartScreen(),
//     ProfileScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: screens[currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         onTap: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },
//         selectedItemColor: kprimaryColor,
//         unselectedItemColor: Colors.grey.shade400,
//         showUnselectedLabels: true,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.trending_up_outlined),
//             label: 'Trending',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite_border),
//             label: 'Favorite',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart_outlined),
//             label: 'Cart',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }
