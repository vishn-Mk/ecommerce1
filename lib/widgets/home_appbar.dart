import 'package:flutter/material.dart';
import '../screens/Cart.dart';
import '../screens/appname_widget.dart';
import '../screens/profiile.dart';
import '../utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[100], // Adjust background color if needed
      leading: PopupMenuButton(
        icon: Icon(Icons.menu, color: Colors.black), // Icon color
        color: Colors.white,
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              value: "Profile",
              child: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            PopupMenuItem(
              value: "Cart",
              child: Text(
                "Cart",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            PopupMenuItem(
              value: "Logout",
              child: Text(
                "Logout",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ];
        },
        onSelected: (value) {
          if (value == "Profile") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          } else if (value == "Cart") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          }

          // Handle menu item click
          print(value);
        },
      ),
      title: const AppNameWidget(),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined, color: Colors.black), // Icon color
          iconSize: 25,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}