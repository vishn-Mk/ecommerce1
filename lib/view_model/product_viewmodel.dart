// import 'package:flutter/material.dart';
//
// import '../models/product_model2.dart';
// import '../services/product_service.dart';
//
// class HomeViewModel extends ChangeNotifier {
//   bool loading = false;
//   List<ProductModel> products = [];
//   List<ProductModel> shoes = [];
//   // List<ProductModel> sneakers = [];
//
//   final _productService = HomeServices();
//
//   Future<void> fetchProducts() async {
//     loading = true;
//     notifyListeners();
//     try {
//       products = await _productService.getProducts();
//       print(products);
//       // Filter products with category 'Sneakers' and add to jackets list
//       shoes = products.where((product) => product.category == 'shoes').toList();
//       // sneakers =
//       //     products.where((product) => product.category == 'Sneakers').toList();
//
//       loading = false;
//       notifyListeners();
//     } catch (e) {
//       loading = false;
//       notifyListeners();
//       print('an error occurred: $e');
//       // Handle error here if needed
//     }
//   }
// }
import 'package:flutter/cupertino.dart';

import '../models/product_model.dart';
import '../services/product_service.dart';

class HomeViewModel extends ChangeNotifier {
  bool loading = false;
  List<ProductModel> products = [];

  final _productService = ProductServices();

  Future<void> fetchProducts() async {
    loading = true;
    notifyListeners();

    try {
      products = await _productService.getProducts();
      print('Products fetched: $products');
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      print('An error occurred: $e');
    }
  }
}
