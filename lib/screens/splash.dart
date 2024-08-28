import 'dart:async';
import 'package:ecommerce/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'login.dart';
// Make sure to import your login page

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('asset/images/splash.jpg'),  // Your splash image
      ),
    );
  }
}
