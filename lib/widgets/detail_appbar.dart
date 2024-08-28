import 'package:ecommerce/provider/favorite_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class DetailAppBar extends StatelessWidget {
  final ProductModel  product;
  const DetailAppBar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(15),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 25,
            icon: const Icon(Icons.arrow_back_ios),
          ),

          const SizedBox(width: 10),

        ],
      ),
    );
  }
}
