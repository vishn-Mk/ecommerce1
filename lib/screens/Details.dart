
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
  int Currentcolor = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //FOR add to cart,
      floatingActionButton: AddToCart(product: widget.product,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Column(
          children: [
            // For back button, share, and favorite,
            DetailAppBar(product:  widget.product,),
            // For detail image slider
            MyImageSlider(
              image: widget.product.image!,
              onChange: (index) {
                setState(() {
                  currentImage = index;
                });
              },
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: currentImage == index ? 15 : 8,
                  height: 8,
                  margin: EdgeInsets.only(right: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: currentImage == index
                        ? Colors.black
                        : Colors.transparent,
                    border: Border.all(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // For product name, price, rating, and seller,
                  ItemDetails(product: widget.product),
                  const SizedBox(
                    height: 20,
                  ),
                  // Text(
                  //   'Color',
                  //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),

                  const SizedBox(height: 23,),
                  // for description,
                  Description(description:  widget.product.description!,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
