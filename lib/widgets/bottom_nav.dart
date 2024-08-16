import 'package:flutter/material.dart';
import '../screens/Cart.dart';
import '../screens/ChatBot.dart';
import '../screens/Favorite.dart';
import '../screens/Home.dart';
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
    Favorite(),
    HomeScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: screens[currentIndex],
      ),
      bottomNavigationBar: Container(
        height: 50, // Further decreased container height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_outlined,
                size: currentIndex == 0 ? 24 : 18, // Further adjusted size
                color: currentIndex == 0 ? Colors.white : Colors.white70,
              ),
              label: 'ChatBot',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border,
                size: currentIndex == 1 ? 24 : 18, // Further adjusted size
                color: currentIndex == 1 ? Colors.white : Colors.white70,
              ),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: currentIndex == 2 ? 24 : 18, // Further adjusted size
                color: currentIndex == 2 ? Colors.white : Colors.white70,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: currentIndex == 3 ? 24 : 18, // Further adjusted size
                color: currentIndex == 3 ? Colors.white : Colors.white70,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: currentIndex == 4 ? 24 : 18, // Further adjusted size
                color: currentIndex == 4 ? Colors.white : Colors.white70,
              ),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          showUnselectedLabels: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          iconSize: 20, // Further adjusted default icon size
          selectedFontSize: 10,
          unselectedFontSize: 8,
        ),
      ),
    );
  }
}
