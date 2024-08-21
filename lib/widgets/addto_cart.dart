import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/auth_services.dart';
import '../models/product_model.dart';
import '../view_model/cart_viewmodel.dart';

class AddToCart extends StatefulWidget {
  final ProductModel product;
  const AddToCart({super.key, required this.product});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartViewModel>();
    final authService = AuthServices();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Quantity Selector
            Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (currentIndex != 1) {
                        setState(() {
                          currentIndex--;
                        });
                      }
                    },
                    iconSize: 20,
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    currentIndex.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex++;
                      });
                    },
                    iconSize: 20,
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // Add to Cart Button with Icon and Gradient
            GestureDetector(
              onTap: () async {
                final userId = await authService.userId;
                if (userId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User not logged in')),
                  );
                  return;
                }

                ProductModel newProduct = ProductModel(
                  title: widget.product.title,
                  image: widget.product.image,
                  price: widget.product.price,
                  sId: widget.product.sId,
                  quantity: widget.product.quantity,
                );

                cartProvider.addProductToCart(
                  userid: userId,
                  product: newProduct,
                  context: context,
                );

                //   ScaffoldMessenger.of(context).showSnackBar(
                //   //   const SnackBar(
                //   //     content: Text(
                //   //       "Successfully added!",
                //   //       style: TextStyle(
                //   //         fontWeight: FontWeight.bold,
                //   //         fontSize: 16,
                //   //         color: Colors.white,
                //   //       ),
                //   //     ),
                //   //   ),
                //   // );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: const [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 22,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Add to Cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
