import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/payment.dart';
import '../screens/success.dart';
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
      height: 250, // Reduced height
      width: 280,  // Reduced width
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade300, Colors.blue.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,  // Reduced spread radius
            blurRadius: 5,    // Reduced blur radius
            offset: const Offset(0, 2), // Adjusted offset
          ),
        ],
      ),
      padding: const EdgeInsets.all(15), // Reduced padding
      child: Column(
        mainAxisSize: MainAxisSize.min, // Adjusted to fit content
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20), // Reduced radius
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,    // Reduced vertical padding
                horizontal: 15, // Reduced horizontal padding
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.9),
              hintText: "Enter Discount Code",
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 12, // Reduced font size
              ),
              suffixIcon: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),   // Reduced radius
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  padding: EdgeInsets.zero, // Removed extra padding
                ),
                child: const Text(
                  "Apply",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12, // Reduced font size
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15), // Reduced spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "SubTotal",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                  fontSize: 14, // Reduced font size
                ),
              ),
              Text(
                "\$${getTotalPrice().toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14, // Reduced font size
                ),
              ),
            ],
          ),
          const SizedBox(height: 8), // Reduced spacing
          Divider(color: Colors.white.withOpacity(0.5), thickness: 1), // Adjusted thickness
          const SizedBox(height: 8), // Reduced spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16, // Slightly increased for emphasis
                  color: Colors.white,
                ),
              ),
              Text(
                "\$${getTotalPrice().toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16, // Slightly increased for emphasis
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20), // Reduced spacing
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Reduced radius
              ),
              elevation: 2, // Reduced elevation
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10), // Adjusted padding
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Payment()),
              );
            },
            child: const Text(
              "Check Out",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16, // Adjusted font size
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
