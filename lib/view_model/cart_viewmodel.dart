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

      // Ensure the quantity is passed to the service
      await _cartService.addProductToCart(userid: userid, product: product);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
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
      cartItems = await _cartService.getCartContents(userid);
      cartData.clear();

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

      await _cartService.removeProductFromCart(userid: userid, productId: productId);

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

  // Update cart item quantity
  Future<void> updateCartItemQuantity(String itemId, int newQuantity, BuildContext context) async {
    loading = true;
    notifyListeners();
    try {
      await CartService.updateCartItemQuantity(itemId, newQuantity);

      final itemIndex = cartItems.indexWhere((item) => item.sId == itemId);
      if (itemIndex != -1) {
        cartItems[itemIndex].quantity = newQuantity;
        notifyListeners();
      } else {
        print('Item not found in cart');
      }
    } catch (error) {
      print('Error updating cart item quantity: $error');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> deleteCartItem(String itemId, BuildContext context) async {
    try {
      loading = true;
      notifyListeners();

      bool isSuccess = await _cartService.deleteItem(itemId);

      if (isSuccess) {
        cartItems.removeWhere((item) => item.sId == itemId);
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
}
