import 'package:flutter/material.dart';


import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../services/cart_services.dart';

class CartViewModel extends ChangeNotifier {
  bool loading = false;
  List<CartModel> cartItems = [];
  List<ProductModel> cartData = [];

  final _cartService = CartService();

  // Add product to cart
  Future<void> addProductToCart({
    required String userid,
    required ProductModel product,
    required BuildContext context,
  }) async {
    try {
      loading = true;
      notifyListeners();

      await _cartService.addProductToCart(userid: userid, product: product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Product added to cart successfully"),
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to add product to cart: $e"),
      ));
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // Fetch cart contents for a user
  Future<void> fetchCartContents(String userid, BuildContext context) async {
    loading = true;
    notifyListeners();

    try {
      // Fetch cart contents
      cartItems = await _cartService.getCartContents(userid);

      // Clear previous cartData
      cartData.clear();

      // Populate cartData with the latest items
      for (var cartItem in cartItems) {
        cartData.add(cartItem.productId! as ProductModel);
      }

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

  // Remove product from cart
  Future<void> removeProductFromCart({
    required String userid,
    required String productId,
    required BuildContext context,
  }) async {
    try {
      loading = true;
      notifyListeners();
      await _cartService.removeProductFromCart(
          userid: userid, productId: productId);
      // Update the local cartItems list after successful removal
      cartItems.removeWhere((item) => item.productId?.sId == productId);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Product removed from cart successfully"),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to remove product from cart: $e"),
      ));
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // Increase product quantity
  Future<void> increaseQuantity({
    required String cartItemId,
    required BuildContext context,
  }) async {
    try {
      await _cartService.increaseQuantity(cartItemId);
      // Refresh the cart contents after increasing quantity
      await fetchCartContents(cartItems.first.userId!, context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Quantity increased successfully"),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to increase quantity: $e"),
      ));
    }
  }

  // Decrease product quantity
  Future<void> decreaseQuantity({
    required String cartItemId,
    required BuildContext context,
  }) async {
    try {
      await _cartService.decreaseQuantity(cartItemId);
      // Refresh the cart contents after decreasing quantity
      await fetchCartContents(cartItems.first.userId!, context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Quantity decreased successfully"),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to decrease quantity: $e"),
      ));
    }
  }
}
