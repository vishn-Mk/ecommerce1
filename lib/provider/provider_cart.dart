import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';


class CartProvider extends ChangeNotifier {
  final List<ProductModel> _cart = [];

  List<ProductModel> get cart => _cart;

  void toggleFavorite(ProductModel product) {
    if (_cart.contains(product)) {
      // Find the specific product and increment its quantity
      for (ProductModel element in _cart) {
        if (element == product) {
          element.quantity++;
          break;
        }
      }
    } else {
      _cart.add(product);
    }
    notifyListeners();
  }
  incrementQtn(int index)=> _cart[index].quantity++;
  decrementQtn(int index)=> _cart[index].quantity--;
  totalPrice(){
    double total1 =0.0;
    for(ProductModel element in _cart){
      total1 += element.price *element.quantity;
    }
    return total1;
  }

  static CartProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CartProvider>(context, listen: listen,);
  }
}
