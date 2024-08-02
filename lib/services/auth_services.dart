import 'dart:convert';

import 'package:http/http.dart' as http;


import '../models/auth_model.dart';
import '../utils/constants.dart';

class AuthServices {
  Future<void> register({required Authmodel auth}) async {
    final Uri url = Uri.parse('$baseurl/api/auth/');

    try {
      print(auth.toJson());
      final response = await http.post(url, body: auth.toJson());

      if (response.statusCode == 200) {

        print('Registration successful');
      } else {
        throw Exception(
            'Failed to register. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during registration: $e');
      throw Exception('An error occurred during registration');
    }
  }

  Future<void> login(
      {required String username, required String password}) async {
    final Uri url = Uri.parse('$baseurl/api/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        print('Login successful');
        // Optionally, you can return or save user data from response
        // return jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        // Handle specific error for bad request
        print('Login failed: ${response.body}');
        throw Exception('Failed to login. ${response.body}');
      } else if (response.statusCode == 401) {
        // Handle unauthorized error
        print('Login failed: Incorrect password');
        throw Exception('Failed to login. Incorrect password.');
      } else {
        print('Login failed: ${response.body}');
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error during login: $e');
      throw Exception('An error occurred during login');
    }
  }
}