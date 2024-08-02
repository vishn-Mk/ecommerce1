import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../utils/product_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<ProductModel> _favorite = [];

  List<ProductModel> get favorite => _favorite;

  void toggleFavorite(ProductModel product) {
    if (_favorite.contains(product)) {
      // Find the specific product and increment its quantity
     if(_favorite.remove(product));
      for (ProductModel element in _favorite) {
        if (element == product) {
          element.quantity++;
          break;
        }
      }
    } else {
      _favorite.add(product);
    }
    notifyListeners();
  }
 bool isExist(ProductModel product){
    final isExist =_favorite.contains(product);
    return isExist;
 }


  static FavoriteProvider of(
      BuildContext context, {bool listen = true
      }) {
    return Provider.of<FavoriteProvider>(context, listen: listen,);
  }
}
