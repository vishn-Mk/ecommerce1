import 'package:flutter/material.dart';

import 'Details.dart';

// Example data structure for a product
class Product {
  final String name;
  final String imageUrl;
  final String price;

  Product({required this.name, required this.imageUrl, required this.price});
}

// Example list of trending products
List<Product> trendingProducts = [
  Product(name: 'Shoes', imageUrl: 'asset/images/shoes.jpg', price: '300'),
  Product(name: 'Kurta', imageUrl: 'asset/images/kurta.png', price: '566'),
  Product(name: 'FaceCare', imageUrl: 'asset/images/face care.png', price: '500'),
  Product(name: 'Shoes', imageUrl: 'asset/images/shoes.jpg', price: '300'),
  Product(name: 'Kurta', imageUrl: 'asset/images/kurta.png', price: '566'),
  Product(name: 'FaceCare', imageUrl: 'asset/images/face care.png', price: '500'),
  // Add more products as needed
];

class TrendingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending'),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    flex: 4,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    height: 25,
                    width: 1.5,
                    color: Colors.grey,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.tune,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GestureDetector(onTap: () {

            },
              child: ListView.builder(
                itemCount: trendingProducts.length,
                itemBuilder: (context, index) {
                  return _buildProductItem(context, trendingProducts[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(BuildContext context, Product product) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 100,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Price: \$${product.price}",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     // Handle add to cart
          //   },
          //   icon: Icon(Icons.add_shopping_cart_sharp, color: Colors.green),
          // ),
        ],
      ),
    );
  }
}
