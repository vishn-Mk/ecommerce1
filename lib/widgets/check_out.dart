import 'package:ecommerce/provider/provider_cart.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/payment.dart';

class CheckOutBox extends StatelessWidget {
  const CheckOutBox({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[1000],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none),
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              filled: true,
              fillColor: kcontentColor,
              hintText: "Enter Discount Code",
              hintStyle:
                  TextStyle(fontWeight: FontWeight.w800, color: Colors.grey),
              suffixIcon: TextButton(
                onPressed: () {},
                child: Text(
                  "Apply",
                  style: TextStyle(color: kprimaryColor),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              Text(
                "\$${cartProvider.totalPrice()}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$${cartProvider.totalPrice()}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder:  (context) => Payment(),));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kprimaryColor,
              maximumSize: Size(double.infinity, 55),
            ),
            child: Text(
              "Check Out",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
