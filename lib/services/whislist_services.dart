import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../models/whislist_model.dart';
import '../utils/constants.dart';

class WishService {
  // Fetch wishlist contents for a user
  Future<List<WishModel>> getWishContents(String userId) async {
    final Uri url = Uri.parse('$baseurl/api/products/wishlist/viewItems/$userId');

    try {
      final response = await http.get(url);
      print('Response body: ${response.body}');
      print('Status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Response data: $data');

        if (data['data'] is List) {
          return (data['data'] as List)
              .map((item) => WishModel.fromJson(item as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('The key "data" is missing or the list is null');
        }
      } else {
        throw Exception('Failed to load wishlist contents');
      }
    } catch (e) {
      print('Error fetching wishlist: $e');
      throw Exception('An error occurred: $e');
    }
  }

  // Delete product from wishlist
  Future<bool> deleteItem(String itemId) async {
    final response = await http.delete(
      Uri.parse('$baseurl/api/products/wishlist/removeItem/$itemId'),
    );
    print(
        "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb${response.body}");

    return response.statusCode == 200;
  }



  // Add item to wishlist
  Future<void> addProductToWish({
    required String userId,
    required ProductModel product,
  }) async {
    final Uri url = Uri.parse('$baseurl/api/products/wishlist/addItem');

    final Map<String, dynamic> cartData = {
      'userId': userId,
      'productId': product.sId,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},  // Ensure JSON content type
        body: jsonEncode(cartData),  // Encode the body to JSON
      );

      if (response.statusCode == 201) {
        print('Product added to wishlist successfully');
      } else {
        throw Exception('Failed to add product to wishlist');
      }
    } catch (e) {
      print(e);
      throw Exception('An error occurred: $e');
    }
  }

  // Fetch product details by productId
  // Update this method in WishService
  Future<ProductModel> getProductDetails(String productId) async {
    final Uri url = Uri.parse('$baseurl/api/products/$productId');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return ProductModel.fromJson(data);
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

}
