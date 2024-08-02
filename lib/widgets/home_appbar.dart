import 'package:flutter/material.dart';
import '../screens/Cart.dart';
import '../screens/profiile.dart';
import '../utils/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          height: 35,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 180),
          child: PopupMenuButton(
            icon: Icon(Icons.menu),
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
        ),
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: kcontentColor,
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () {},
          iconSize: 25,
          icon: const Icon(Icons.notifications_outlined),
        ),
      ],
    );
  }
}
