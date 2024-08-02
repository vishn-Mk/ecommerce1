import 'package:ecommerce/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

import '../models/auth_model.dart';
import '../screens/login.dart';
import '../services/auth_services.dart';

class AuthViewModel extends ChangeNotifier {
  bool loading = false;
  final _authService = AuthServices();

  Future<void> Registration(
      {required Authmodel auth, required BuildContext context}) async {
    try {
      loading = true;
      notifyListeners();
      await _authService.register(auth: auth);

      loading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } catch (e) {
      loading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  Future<void> login(
      {required Username,
        required password,
        required BuildContext context}) async {
    try {
      loading = true;
      notifyListeners();
      await _authService.login(username: Username, password: password);

      loading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful!')),
      );

      // Navigate to login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBar()),
      );
    } catch (e) {
      loading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }
}