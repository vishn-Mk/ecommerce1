// import 'dart:convert';
//
// import 'package:ecommerce_mobile_app/constants.dart';
// import 'package:http/http.dart' as http;
//
// import '../models/product_model2.dart';
//
// class HomeServices {
//   Future<List<ProductModel>> getProducts() async {
//     try {
//       final response =
//           await http.get(Uri.parse('$baseurl/api/product/viewProduct'));
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//
//         print('Response data: $data');
//         if (data['data'] is List) {
//           var productList = (data['data'] as List)
//               .map(
//                   (item) => ProductModel.fromJson(item as Map<String, dynamic>))
//               .toList();
//           print('Product list: $productList');
//
//           return productList;
//         } else {
//           throw Exception('The key "products" is missing or the list is null');
//         }
//       } else {
//         throw Exception('Failed to load products');
//       }
//     } catch (e) {
//       throw Exception('An error occurred: $e');
//     }
//   }
// }
import 'dart:convert';

import 'package:http/http.dart' as http;


import '../models/product_model.dart';

import '../utils/constants.dart';

class ProductServices {
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseurl/api/products/viewProduct'));

      if (response.statusCode == 200) {
        print(response.body);
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['data'] is List) {
          var productList = (data['data'] as List)
              .map(
                  (item) => ProductModel.fromJson(item as Map<String, dynamic>))
              .toList();
          print("helo");

          print('$productList');

          return productList;
        } else {
          throw Exception('The key "data" does not contain a list');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}