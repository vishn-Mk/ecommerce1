import 'package:confetti/confetti.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:flutter/material.dart';

import '../screens/Cart.dart';
import '../screens/ChatBot.dart';
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
  int notificationCount = 5; // Example notification count

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
                PopupMenuItem(
                  value: "ChatBot",
                  child: Text(
                    "ChatBot",
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
              } else if (value == "ChatBot") { // Corrected condition for ChatBot
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()), // Ensure the screen name is correct
                );
                _showFireworks(); // Trigger fireworks when ChatBot is selected
              } else if (value == "Logout") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
                _showFireworks(); // Trigger fireworks when Logout is selected
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
            Stack(
              children: [
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
                if (notificationCount > 0)
                  Positioned(
                    right: 11,
                    top: 11,
                    child: Container(
                      padding: EdgeInsets.all(1), // Adjust padding for badge
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10), // Badge shape
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16, // Badge size
                        minHeight: 16, // Badge size
                      ),
                      child: Center(
                        child: Text(
                          '$notificationCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10, // Font size for badge
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
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
