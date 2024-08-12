import 'package:ecommerce/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Description extends StatelessWidget {
  final String description;
  const Description({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(scrollDirection: Axis.vertical,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Description",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                // Text(
                //   "Specifications",
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     color: Colors.black,
                //     fontSize: 16,
                //   ),
                // ),
                // Text(
                //   "Reviews",
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     color: Colors.black,
                //     fontSize: 16,
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            description,
            style: TextStyle(fontSize: 16, color: Colors.grey,),
          ),
        ],
      ),
    );
  }
}
