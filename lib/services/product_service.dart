import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../utils/constants.dart';

class ProductServices {
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseurl/api/products/viewProduct'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['data'] is List) {
          return (data['data'] as List)
              .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final response = await http.get(Uri.parse('$baseurl/api/products/viewProduct?category=$category'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['data'] is List) {
          return (data['data'] as List)
              .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('Failed to load products by category');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
