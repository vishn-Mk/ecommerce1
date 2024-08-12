import 'package:flutter/material.dart';
import '../models/product_model.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  _MySearchBarState createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final TextEditingController _controller = TextEditingController();
  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    // Example initialization of allProducts. Replace with actual data fetching logic.
    allProducts = [

      // Add more products here
    ];
    filteredProducts = allProducts;

    _controller.addListener(_filterProducts);
  }

  void _filterProducts() {
    final query = _controller.text.toLowerCase();
    setState(() {
      filteredProducts = allProducts.where((product) {
        final title = product.title?.toLowerCase() ?? '';
        return title.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_filterProducts);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.black,
            size: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            flex: 4,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
              onChanged: (query) => _filterProducts(), // Call _filterProducts on text change
            ),
          ),
          Container(
            height: 25,
            width: 1.5,
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {
              _filterProducts(); // Call _filterProducts when the button is pressed
            },
            icon: Icon(
              Icons.tune,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
