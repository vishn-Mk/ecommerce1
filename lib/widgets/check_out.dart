
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../utils/constants.dart';
import '../view_model/cart_viewmodel.dart';

class CheckOutBox extends StatelessWidget {
  const CheckOutBox({super.key});

  @override
  Widget build(BuildContext context) {
    final cartprovider = context.watch<CartViewModel>();
    double getTotalPrice() {
      double total = 0.0;
      for (var item in cartprovider.cartItems) {
        double price = item.productId?.price?.toDouble() ?? 0.0;
        int qty = item.quantity ?? 0;
        total += price * qty;
      }
      return total;
    }

    return Container(
      height: 300,
      width: 300,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // TextField(
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(30),
          //       borderSide: BorderSide.none,
          //     ),
          //     contentPadding: const EdgeInsets.symmetric(
          //       vertical: 5,
          //       horizontal: 15,
          //     ),
          //     filled: true,
          //     fillColor: kcontentColor,
          //     hintText: "Enter Discount Code",
          //     hintStyle: const TextStyle(
          //       color: Colors.grey,
          //       fontWeight: FontWeight.w600,
          //       fontSize: 14,
          //     ),
          //     suffixIcon: TextButton(
          //       onPressed: () {},
          //       child: const Text(
          //         "Apply",
          //         style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 20,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "SubTotal",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                "\$${getTotalPrice().toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "total",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                "\$${getTotalPrice().toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
          const SizedBox(height: 50),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 55),
              ),
              onPressed: () {},
              child: const Text(
                "Check Out",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }
}
// now we add the provider and display the total price