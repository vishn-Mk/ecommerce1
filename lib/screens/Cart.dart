import 'package:ecommerce/provider/provider_cart.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:ecommerce/widgets/bottom_nav.dart';
import 'package:ecommerce/widgets/check_out.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final finalList = provider.cart;

    // Method for updating product quantity
    Widget productQuantity(IconData icon, int index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            if (icon == Icons.add) {
              provider.incrementQtn(index);
            } else {
              provider.decrementQtn(index);
            }
          },
          );
        },
        child: Icon(
          icon,
          color: Colors.black,
          size: 18,
        ),
      );
    }

    return Scaffold(
      bottomSheet: CheckOutBox(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(15),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavBar(),
                        ),
                      );
                    },
                    iconSize: 25,
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Text(
                    "My Cart",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(), // Placeholder for alignment
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: finalList.length,
                itemBuilder: (context, index) {
                  final cartItem = finalList[index];
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Container(
                                height: 120,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: kcontentColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Image.network(cartItem.image!),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItem.title!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    cartItem.category!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "\$${cartItem.price}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 35,
                        right: 35,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                finalList.removeAt(index);
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 25,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: kcontentColor,
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  productQuantity(Icons.add, index),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    cartItem.quantity.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  productQuantity(Icons.remove, index),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
