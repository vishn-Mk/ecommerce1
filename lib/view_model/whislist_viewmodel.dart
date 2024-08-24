import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/whislist_model.dart';
import '../services/whislist_services.dart';

class WishViewModel extends ChangeNotifier {
  bool loading = false;
  List<WishModel> wishItems = [];
  List<ProductModel> wishData = [];


  final _wishService = WishService();

//   Future<void> fetchWishContents(String userId, BuildContext context) async {
//     loading = true;
//     notifyListeners();
// print("  =========================${wishData}");
//     try {
//       wishItems = await _wishService.getWishContents(userId);
//       print('Fetched wishItems: $wishItems');
//
//       wishData.clear();
//       for (var wishItem in wishItems) {
//         if (wishItem.productId != null && wishItem.productId!.sId != null) {
//           var product = await _wishService.getProductDetails(wishItem.productId!.sId!);
//           print('Fetched product: $product');
//           wishData.add(product);
//         }
//       }
//       print('cccccccccccccccccccccPopulated wishData: $wishData');
//
//       notifyListeners();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Failed to fetch wishlist contents: $e"),
//       ));
//     } finally {
//       loading = false;
//       notifyListeners();
//     }
//   }
  Future<void> fetchWishContents(String userid, BuildContext context) async {
    loading = true;
    notifyListeners();

    try {
      // Fetch cart contents
      wishItems = await _wishService.getWishContents(userid);

      // Clear previous cartData
      wishData.clear();

      // Populate cartData with the latest items
      for (var wishItem in wishItems) {
        wishData.add(wishItem.productId!);
      }
      print("hiiiiiiiiiiiiiiii${wishData.length}");

      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to fetch cart contents: $e"),
      ));
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> deleteWishItem(String itemId, BuildContext context) async {
    try {
      print("gggggggggggggggggggggggggggggggggg${itemId}");
      loading = true;
      notifyListeners();

      bool isSuccess = await _wishService.deleteItem(itemId);

      if (isSuccess) {
        // Remove the item from the local list
        wishItems.removeWhere((item) => item.sId == itemId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item deleted successfully.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete item.')),
        );
      }
    } catch (e) {
      print('Delete error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      loading = false;
      notifyListeners();
    }
  }


  Future<void> addProductToWish({
    required String userId,
    required ProductModel product,
    required BuildContext context,
  }) async {
    try {
      loading = true;
      notifyListeners();

      await _wishService.addProductToWish(userId: userId, product: product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Product added to wishlist successfully"),
        ),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to add product to wishlist: $e"),
      ));
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
