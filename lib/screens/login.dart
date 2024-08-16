import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../view_model/auth_viewmodel.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Background SVG
          Container(
            height: MediaQuery.of(context).size.height * 0.4, // Adjust height as needed
            child: SvgPicture.asset(
              'asset/icons/login.svg', // Path to your SVG asset
              fit: BoxFit.cover,
            ),
          ),
          // Login Form
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
                       // Add some space from the SVG

                        // Welcome Text
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Ensure text color contrasts with background
                          ),
                        ),

                        SizedBox(height: 30),

                        // Username
                        custom_textfeild(
                          controller: usernameController,
                          labeltext: 'Username',
                        ),

                        SizedBox(height: 20),

                        // Password
                        custom_textfeild(
                          controller: passwordController,
                          labeltext: "Password",
                          isPassword: true,
                        ),

                        SizedBox(height: 20),

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
                                value.login(
                                  Username: usernameController.text,
                                  password: passwordController.text,
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
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide.none,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            minimumSize: Size(double.infinity, 50),
                          ),
                          icon: Image.asset('asset/images/google-logo-9808.png',
                              height: 24),
                          label: Text(
                            'Sign in with Google',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),

                        SizedBox(height: 20),

                        // Sign Up Text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't Have An Account?",
                              style: TextStyle(color: Color(0xFF707B81)),
                            ),
                            CustomButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUp(),
                                  ),
                                );
                              },
                            ),
                          ],
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
