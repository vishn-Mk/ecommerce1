import 'package:ecommerce/screens/Details.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:ecommerce/utils/product_model.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../provider/favorite_provider.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  product: product,
                ),
              ));
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[50]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Hero(
                      tag: product.image!,
                      child: Image.network(
                        product.image!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      product.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "\$${product.price}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ), // for favorite icon
            Positioned(
                child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 35,
                width: 40,
                decoration: BoxDecoration(
                  color: kprimaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(
                      20,
                    ),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    provider.toggleFavorite(product);
                  },
                  child: Icon(
                    provider.isExist(product) ?
                    Icons.favorite:
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
