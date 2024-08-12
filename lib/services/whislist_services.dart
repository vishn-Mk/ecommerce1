import 'dart:convert';

import 'package:http/http.dart' as http;


import '../models/product_model.dart';

import '../models/whislist_model.dart';

import '../utils/constants.dart';

class WishService {
  // Fetch cart contents for a user
  Future<List<WishModel>> getWishContents(String userid) async {
    final Uri url = Uri.parse('$baseurl/api/products/wishlist/viewItems/$userid');

    try {
      final response = await http.get(url);
      print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
      print("ccccccccccccccc${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Response data: $data');

        if (data['data'] is List) {
          var wishList = (data['data'] as List)
              .map((item) => WishModel.fromJson(item as Map<String, dynamic>))
              .toList();
          print('Wish list: $wishList');

          return wishList;
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

//delete product from wishlist
  Future<bool> deleteItem(String itemId) async {
    final response = await http.delete(
      Uri.parse('$baseurl/api/wishlist/removeItem/$itemId'),
    );
    print(
        "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb${response.body}");

    return response.statusCode == 200;
  }

  // add item to wishlist

  Future<void> addProductToWish(
      {required String userid, required ProductModel product}) async {
    final Uri url = Uri.parse('$baseurl/api/wishlist/addItem');
    print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb${product.sId}");

    final Map<String, dynamic> cartData = {
      'userId': userid,
      'productId': product.sId,
    };

    try {
      final response = await http.post(url, body: cartData);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201) {
        print('Product added to cart successfully');
      } else {
        print('3');
        throw Exception('Failed to add product to cart');
      }
    } catch (e) {
      print(e);
      throw Exception('An error occurred: $e');
    }
  }
}