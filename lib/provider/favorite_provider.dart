import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<ProductModel> _favorites = [];

  List<ProductModel> get favorites => _favorites;

  void toggleFavorite(ProductModel product) {
    if (_favorites.contains(product)) {
      // If the product is already in the favorites list, remove it
      _favorites.remove(product);
    } else {
      // If the product is not in the favorites list, add it
      _favorites.add(product);
    }
    notifyListeners();
  }

  bool isExist(ProductModel product) {
    return _favorites.contains(product);
  }

  static FavoriteProvider of(
      BuildContext context, {
        bool listen = true,
      }) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }
}
