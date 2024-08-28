import 'package:ecommerce/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/Cart.dart';
import '../screens/ChatBot.dart';
import '../screens/Favorite.dart';
import '../screens/Home.dart';

import '../screens/profiile.dart';
import '../view_model/cart_viewmodel.dart';
import '../view_model/whislist_viewmodel.dart'; // Import the CartViewModel

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
    final cartProvider = context.watch<CartViewModel>(); // Access CartViewModel
    int cartItemCount = cartProvider.cartItems.length; // Get cart item count

    // For demonstration, let's assume you have a favorite item count as well
   final wishProvider =context.watch<WishViewModel>();
    int favoriteItemCount = wishProvider.wishItems.length; // Replace with your actual favorite item count

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
        height: 54, // Container height for better clickability
        decoration: BoxDecoration(
          color: Colors.white, // Changed to solid white for better visibility
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
                size: currentIndex == 0 ? 24 : 20, // Adjusted icon size
                color: currentIndex == 0 ? Colors.blue : Colors.grey[600], // Changed color
              ),
              label: 'ChatBot',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: currentIndex == 1 ? 24 : 20, // Adjusted icon size
                    color: currentIndex == 1 ? Colors.blue : Colors.grey[600], // Changed color
                  ),
                  if (favoriteItemCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.all(1), // Padding for the badge
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15), // Badge shape
                        ),
                        constraints: BoxConstraints(
                          minWidth: 14, // Badge width
                          minHeight: 14, // Badge height
                        ),
                        child: Center(
                          child: Text(
                            '$favoriteItemCount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 7, // Font size for badge
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: currentIndex == 2 ? 24 : 20, // Adjusted icon size
                color: currentIndex == 2 ? Colors.blue : Colors.grey[600], // Changed color
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: currentIndex == 3 ? 24 : 20, // Adjusted icon size
                    color: currentIndex == 3 ? Colors.blue : Colors.grey[600], // Changed color
                  ),
                  if (cartItemCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                     // Adjusted top position
                      child: Container(
                        padding: EdgeInsets.all(1), // Reduced padding for a smaller container
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15), // Reduced border radius
                        ),
                        constraints: BoxConstraints(
                          minWidth: 14, // Reduced minimum width
                          minHeight: 14, // Reduced minimum height
                        ),
                        child: Center(
                          child: Text(
                            '$cartItemCount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 7, // Font size for cart item count
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: currentIndex == 4 ? 24 : 20, // Adjusted icon size
                color: currentIndex == 4 ? Colors.blue : Colors.grey[600], // Changed color
              ),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.blue, // Color for selected item
          unselectedItemColor: Colors.grey[600], // Color for unselected items
          showUnselectedLabels: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: TextStyle(fontSize: 10),
          iconSize: 24, // Default icon size adjusted
          selectedFontSize: 12,
          unselectedFontSize: 10,
        ),
      ),
    );
  }
}
