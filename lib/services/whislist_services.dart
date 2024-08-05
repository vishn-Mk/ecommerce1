import 'dart:convert';

import 'package:http/http.dart' as http;


import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../utils/constants.dart';


class whislistViewModel {
  // Add product to cart
  Future<void> addProductToCart({
    required String userid,
    required ProductModel product,
  }) async {
    final Uri url = Uri.parse('$baseurl/api/wishlist/addItem');
    print("Product ID: ${product.sId}");
    print("Product Category: ${product.category}");

    final Map<String, dynamic> cartData = {
      'userId': userid,
      'productId': product.sId,
      'quantity': product.quantity.toString(),
    };

    try {
      final response = await http.post(url, body: cartData);
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        print('Product added to cart successfully');
      } else {
        print('Failed to add product to cart');
        throw Exception('Failed to add product to cart');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('An error occurred: $e');
    }
  }


  // Fetch cart contents for a user
  Future<List<CartModel>> getCartContents(String userid) async {
    final Uri url = Uri.parse('$baseurl/api/wishlist/viewItems/${userid}');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Response data: $data');

        if (data['data'] is List) {
          var cartList = (data['data'] as List)
              .map((item) => CartModel.fromJson(item as Map<String, dynamic>))
              .toList();
          print('Cart list: $cartList');

          return cartList;
        } else {
          throw Exception('The key "data" is missing or the list is null');
        }
      } else {
        throw Exception('Failed to load cart contents');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  // Remove product from cart
  Future<void> removeProductFromCart({
    required String userid,
    required String productId,
  }) async {
    final Uri url =
    Uri.parse('$baseurl/api/wishlist/removeItem/$userid/$productId');
    final Map<String, dynamic> cartData = {
      'userid': userid,
      'productId': productId,
    };

    print(userid);
    print(productId);

    try {
      final response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(cartData),
      );

      if (response.statusCode == 200) {
        print('Product removed from cart successfully');
      } else {
        throw Exception('Failed to remove product from cart-');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  // Increase product quantity
   Future<bool> deleteItem(String itemId) async {
    final response = await http.delete(
      Uri.parse('$baseurl/api/cart/removeItem/$itemId'),
    );

    return response.statusCode == 200;
  }

}

