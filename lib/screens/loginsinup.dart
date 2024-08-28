import 'package:ecommerce/screens/signup.dart';
import 'package:flutter/material.dart';


import 'login.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));

          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 15),
            minimumSize: Size(double.infinity, 50),
          ),
          child: Text(
            'LOGIN',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));

          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 15),
            minimumSize: Size(double.infinity, 50),
          ),
          child: Text(
            'Sign In',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}