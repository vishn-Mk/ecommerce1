import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../provider/favorite_provider.dart';
import '../services/auth_services.dart';
import '../view_model/whislist_viewmodel.dart';
import '../screens/Details.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final wishProvider = context.watch<WishViewModel>();
    final authService = AuthServices();
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
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
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
                  SizedBox(height: 10),
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
                  SizedBox(height: 7),
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
            ),
            // For favorite icon
            Positioned(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 35,
                  width: 40,
                  child: GestureDetector(
                    onTap: ()  async{


                      // Toggle the favorite state
                      provider.toggleFavorite(product);

                      // Ensure userId is available
                      final userId = authService.userId;
                      if (userId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User not logged in')),
                        );
                        return;
                      }

                      // Add product to wishlist
                      try {
                        await wishProvider.addProductToWish(
                          userId: userId,
                          product: product,
                          context: context, userid: '',
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to add to wishlist: $e'),
                          ),
                        );
                      }
                    },
                    child: Icon(
                      provider.isExist(product)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.blue[500],
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}