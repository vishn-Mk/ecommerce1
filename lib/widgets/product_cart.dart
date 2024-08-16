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
    final provider = Provider.of<FavoriteProvider>(context);
    final authService = AuthServices();

    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(
                product: product,
              ),
            ),
          );
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
                      product.title!,
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
                      // Rating Container
                      Container(
                        width: 55,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue,
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 15,
                              color: Colors.white,
                            ),
                            SizedBox(width: 3),
                            Text(
                              product.rate.toString(),
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
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
                    onTap: () async {
                      try {
                        provider.toggleFavorite(product);

                        final userId = await authService.userId;
                        if (userId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('User not logged in')),
                          );
                          return;
                        }

                        ProductModel newProduct = ProductModel(
                          title: product.title,
                          image: product.image,
                          price: product.price,
                          sId: product.sId,
                          quantity: product.quantity,
                        );

                        await wishProvider.addProductToWish(
                          userId: userId,
                          product: newProduct,
                          context: context,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Product added to wishlist')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to add to wishlist: $e')),
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
