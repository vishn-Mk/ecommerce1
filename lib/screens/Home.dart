import 'package:ecommerce/services/product_service.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:ecommerce/widgets/category.dart';
import 'package:ecommerce/widgets/product_cart.dart';
import 'package:ecommerce/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../view_model/product_viewmodel.dart';
import '../widgets/home_appbar.dart';
import '../widgets/image.sliderbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSlider = 0;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<HomeViewModel>(context, listen: false).fetchProducts();

      print(Provider.of<HomeViewModel>(context, listen: false).products);
      print('------');
    });
  }

  @override
  Widget build(BuildContext context) {
    final value = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              CustomAppBar(),
              SizedBox(height: 10),
              MySearchBar(),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ImageSliderBar(
                  currentSlide: currentSlider,
                  onchange: (value) {
                    setState(() {
                      currentSlider = value;
                    });
                  },
                ),
              ),
              // SizedBox(height: 20),
              // SizedBox(
              //   height: 130,
                // child: ListView.builder(
                //   scrollDirection: Axis.horizontal,
                //   itemCount: categoriesList.length,
                //   itemBuilder: (context, index) {
                //     return GestureDetector(
                //       onTap: () {
                //         setState(() {
                //           selectedIndex = index;
                //         });
                //       },
                //       child: Container(
                //         margin: EdgeInsets.only(right: 10),
                //         padding: EdgeInsets.all(8),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(15),
                //           color: selectedIndex == index ? Colors.blue : Colors.white,
                //           border: Border.all(color: Colors.white, width: 1.5),
                //           boxShadow: [
                //             BoxShadow(
                //               color: Colors.grey.withOpacity(0.3),
                //               spreadRadius: 2,
                //               blurRadius: 5,
                //             ),
                //           ],
                //         ),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Container(
                //               height: 65,
                //               width: 65,
                //               decoration: BoxDecoration(
                //                 shape: BoxShape.circle,
                //                 image: DecorationImage(
                //                   image: AssetImage(categoriesList[index].image),
                //                   fit: BoxFit.cover,
                //                 ),
                //               ),
                //             ),
                //             SizedBox(height: 10),
                //             Text(
                //               categoriesList[index].title,
                //               style: TextStyle(
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.w600,
                //                 color: selectedIndex == index ? Colors.white : Colors.black,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     );
                //   },
                // ),
              // ),
              // SizedBox(height: 20),
              if (value.products.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Special for You',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              else
                Center(child: Text('No products available')),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: value.products.isEmpty ? 0 : value.products.length,
                itemBuilder: (context, index) {
                  if (value.products.isEmpty) {
                    return Center(child: Text('No products available'));
                  }
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ProductCard(
                      product: value.products[index],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
