import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../view_model/product_viewmodel.dart';
import '../widgets/category.dart';
import '../widgets/home_appbar.dart';
import '../widgets/image.sliderbar.dart';

import '../widgets/product_cart.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSlider = 0;
  int selectedIndex = 0;
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<HomeViewModel>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final value = context.watch<HomeViewModel>();

    List<ProductModel> displayedProducts = _getDisplayedProducts(value);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const CustomAppBar(),

              const MySearchBar(),
              const SizedBox(height: 5),
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
              const SizedBox(height: 10),
              Categories(
                onCategorySelected: (index) async {
                  setState(() {
                    selectedIndex = index;
                    selectedCategory = categoriesList[index].title;
                  });
                  await Provider.of<HomeViewModel>(context, listen: false)
                      .fetchProductsByCategory(categoriesList[index].title);
                },
              ),

              if (selectedIndex == 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // Check if the products list is not empty before accessing
                      "Explore All Items",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                  ],
                ),

              // if (value.loading)
              //   const Center(child: CircularProgressIndicator())
              // else if (displayedProducts.isNotEmpty)
              //   Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 10),
              //     child: Text(
              //       'Special for You',
              //       style: const TextStyle(
              //         fontSize: 22,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.black,
              //       ),
              //     ),
              //   )
              // else
              //   const Center(child: Text('No products available')),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
                itemCount: displayedProducts.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: ProductCard(
                      product: displayedProducts[index],
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

  List<ProductModel> _getDisplayedProducts(HomeViewModel value) {
    switch (selectedCategory) {
      case 'Shoes':
        return value.shoes;
      case 'Beauty':
        return value.beauty;
      case 'Women':
        return value.womenFashion;
      case 'Jewelry':
        return value.jewelry;
      case 'Men':
        return value.menFashion;
      default:
        return value.products;
    }
  }
}