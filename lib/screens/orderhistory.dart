import 'package:flutter/material.dart';

import 'delivery.dart';

// Example data structure for an order
class Order {
  final String productName;
  final String orderDate;
  final String status;
  final String imageUrl; // Example: URL or asset path for product image

  Order({
    required this.productName,
    required this.orderDate,
    required this.status,
    required this.imageUrl,
  });
}

// Example list of orders (replace with your data)
List<Order> orders = [
  Order(
    productName: 'Product 1',
    orderDate: '2023-06-26',
    status: 'Delivered',
    imageUrl: 'asset/images/wedding ring.png',
  ),
  Order(
    productName: 'Product 2',
    orderDate: '2023-06-25',
    status: 'Pending',
    imageUrl: 'asset/images/watch.png',
  ),
  // Add more orders as needed
];

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDeliveryScreen(),));
      },
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return _buildOrderItem(context, orders[index]);
          },
        ),
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, Order order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              order.imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            order.productName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.0),
              Text(
                'Order Date: ${order.orderDate}',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Status: ${order.status}',
                style: TextStyle(
                  color: _getStatusColor(order.status),
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          onTap: () {
            // Handle tapping on an order (if needed)
          },
        ),
      ),
    );
  }

  // Helper method to determine status color
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.black;
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: OrderHistoryScreen(),
  ));
}
