import 'package:ecommerce/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../view_model/auth_viewmodel.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

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
    double height = MediaQuery.of(context).size.height;
    print(height);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                // child: Icon(
                //   Icons.arrow_back_ios,
                //   color: Colors.black,
                // ),
              ),
            ),
            // Add some spacing if needed
          ],
        ),
        backgroundColor:
        Color(0xFFF8F9FA), // Set the background color of the AppBar
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
                    // Logo

                    SizedBox(height: 20),

                    // Welcome Text
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text(
                    //   "Welcome Back You've Been Missed!",
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     color: Colors.grey,
                    //   ),
                    // ),

                    SizedBox(height: 30),

                    // Email Address
                    custom_textfeild(
                      controller: usernameController,
                      labeltext: 'username',
                    ),

                    SizedBox(height: 20),

                    // Password
                    custom_textfeild(
                      controller: passwordController,
                      labeltext: "Password",
                      isPassword: true,
                    ),
                    // Recovery Password
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => RecoveryScreen(),
                    //           ));
                    //     },
                    //     child: Text(
                    //       'Recovery Password',
                    //       style: TextStyle(color: Color(0xFF707B81)),
                    //     ),
                    //   ),
                    // ),

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
                                context: context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
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

                    SizedBox(
                      height: 170,
                    ),
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
                                ));
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
    );
  }
}