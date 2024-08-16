import 'package:confetti/confetti.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:flutter/material.dart';

import '../screens/Cart.dart';
import '../screens/appname_widget.dart';
import '../screens/profiile.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
    _showFireworks(); // Trigger fireworks automatically when the app bar is built
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _showFireworks() {
    _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
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
                _showFireworks(); // Trigger fireworks when Cart is selected
              }
              else if (value == "Logout") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
                _showFireworks(); // Trigger fireworks when Cart is selected
              }
              print(value);
            },
          ),
          title: GestureDetector(
            onTap: () {
              _showFireworks(); // Trigger fireworks when AppNameWidget is tapped
            },
            child: const AppNameWidget(),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                _showFireworks(); // Trigger fireworks when notification icon is pressed
              },
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ), // Icon color
              iconSize: 25,
            ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Colors.red,
              Colors.blue,
              Colors.yellow,
              Colors.green,
              Colors.cyan,
              Colors.red,
              Colors.black,
              Colors.lightGreen,
              Colors.deepOrangeAccent,
              Colors.deepPurpleAccent,
              Colors.red,
              Colors.blue,
              Colors.yellow,
              Colors.green,
            ],
          ),
        ),
      ],
    );
  }
}
