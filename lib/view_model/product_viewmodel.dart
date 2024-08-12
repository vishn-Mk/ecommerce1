import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class HomeViewModel extends ChangeNotifier {
  bool loading = false;
  List<ProductModel> products = [];
  List<ProductModel> shoes = [];
  List<ProductModel> beauty = [];
  List<ProductModel> womenFashion = [];
  List<ProductModel> jewelry = [];
  List<ProductModel> menFashion = [];

  final _productService = ProductServices();

  Future<void> fetchProducts() async {
    loading = true;
    notifyListeners();

    try {
      products = await _productService.getProducts();
      _filterProducts();
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      print('An error occurred: $e');
    }
  }

  Future<void> fetchProductsByCategory(String category) async {
    loading = true;
    notifyListeners();

    try {
      products = await _productService.getProductsByCategory(category);
      _filterProducts();
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      print('An error occurred: $e');
    }
  }

  void _filterProducts() {
    shoes = products.where((product) => product.category == 'shoes').toList();
    beauty = products.where((product) => product.category == 'beauty').toList();
    womenFashion = products.where((product) => product.category == 'Women').toList();
    jewelry = products.where((product) => product.category == 'jewelry').toList();
    menFashion = products.where((product) => product.category == 'Men').toList();
  }
}
