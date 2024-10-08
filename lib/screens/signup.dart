import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      body: Column(
        children: [
          // Background SVG
          Container(
            height: MediaQuery.of(context).size.height * 0.2, // Adjust height as needed
            child: SvgPicture.asset(
              'asset/icons/signup.svg', // Path to your SVG asset
              fit: BoxFit.cover,
            ),
          ),
          // Sign Up Form
          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  color: Colors.transparent, // Make the background transparent to show SVG
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Space between SVG and form

                        // Welcome Text
                        Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Airbnb",
                            color: Colors.black, // Ensure text color contrasts with background
                          ),
                        ),
                        Text(
                          "Let's Create Account Together",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),

                        SizedBox(height: 30),

                        // Name
                        custom_textfeild(
                          controller: nameController,
                          labeltext: 'Name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

                        // Username
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

                        // Phone
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
                        SizedBox(height: 20),

                        // Password
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

                        // Sign Up Button
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
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        // Sign Up with Google Button
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide.none,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            minimumSize: Size(double.infinity, 50),
                          ),
                          icon: Image.asset('asset/images/google-logo-9808.png',
                              height: 24),
                          label: Text(
                            'Sign up with Google',
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
        ],
      ),
    );
  }
}
