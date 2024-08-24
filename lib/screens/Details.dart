import 'package:ecommerce/utils/product_model.dart';
import 'package:ecommerce/widgets/addto_cart.dart';
import 'package:ecommerce/widgets/description.dart';
import 'package:ecommerce/widgets/image_slider2.dart';
import 'package:ecommerce/widgets/item_datail.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/detail_appbar.dart';

class DetailsScreen extends StatefulWidget {
  final ProductModel product;
  const DetailsScreen({super.key, required this.product});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int currentImage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: AddToCart(product: widget.product),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar with back button, share, and favorite
            DetailAppBar(product: widget.product),

            // Curved Container for Image Slider
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),

              ),
              child: Container(
                color: Colors.white,
                // Background color for the curved container
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: MyImageSlider(
                  image: widget.product.image!,
                  onChange: (index) {
                    setState(() {
                      currentImage = index;
                    });
                  },
                ),
              ),
            ),




            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: currentImage == index ? 15 : 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: currentImage == index ? Colors.black : Colors.transparent,
                    border: Border.all(color: Colors.black),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Main Content Container
            Expanded(
              child: Container(
                width: double.infinity,
                decoration:  BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 100,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name, Price, Rating, and Seller Information
                      ItemDetails(product: widget.product),
                      const SizedBox(height: 20),

                      // Product Description Section
                      Description(description: widget.product.description!),
                    ],
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
