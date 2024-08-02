import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'Cart.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate a delay for the loading indicator
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _isLoading
              ? CircularProgressIndicator()
              : Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 100,
          ),
          SizedBox(height: 30),
          Text(
            "Your Payment Was Done Successfully",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kprimaryColor,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 83),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  'Ok',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
