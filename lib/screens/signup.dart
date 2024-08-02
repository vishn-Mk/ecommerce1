import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../models/auth_model.dart';

import '../view_model/auth_viewmodel.dart';
import '../widgets/custom_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pop(); // Add navigation functionality if needed
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFFF8F9FA),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Color(0xFFF8F9FA),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),

                    // Welcome Text
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Airbnb",
                      ),
                    ),
                    Text(
                      "Let's Create Account Together",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),

                    SizedBox(height: 30),

                    // Email Address
                    custom_textfeild(
                      controller: nameController,
                      labeltext: ' Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    custom_textfeild(
                      controller: usernameController,
                      labeltext: 'Username',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20),

                    // Email Address
                    custom_textfeild(
                      controller: emailController,
                      labeltext: 'Email Address',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    custom_textfeild(
                      controller: phoneController,
                      labeltext: 'Phone',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                    custom_textfeild(
                      controller: passwordController,
                      labeltext: 'Password',
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20),

                    // Sign In Button
                    Consumer<AuthViewModel>(
                      builder: (context, value, child) => value.loading
                          ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      )
                          : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            value.Registration(
                              auth: Authmodel(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                                username: usernameController.text,
                              ),
                              context: context,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    // Sign In with Google Button
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide.none,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      icon: Image.asset('assets/images/Group 108.png',
                          height: 24),
                      label: Text(
                        'Sign in with Google',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}