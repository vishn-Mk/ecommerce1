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
              const SizedBox(height: 5),
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
                Transform.translate(
                  offset: const Offset(0, -6), // Reduce space here
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Explore All Items",
                        style: TextStyle(
                          fontSize: 16, // Adjust font size here
                          fontWeight: FontWeight.bold, // Adjust font weight here
                          color: Colors.black,
                          fontFamily: 'Poppins', // Adjust font family here
                          letterSpacing: 1.1, // Adjust letter spacing here
                        ),
                      ),
                    ],
                  ),
                ),
              Transform.translate(
                offset: const Offset(0, -39), // Reduce space here
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    childAspectRatio: 0.75, // Aspect ratio for each item
                    crossAxisSpacing: 5, // Horizontal spacing between items
                    mainAxisSpacing: 1, // Vertical spacing between items
                  ),
                  itemCount: displayedProducts.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: displayedProducts[index],
                    );
                  },
                ),
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
