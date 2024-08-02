import 'package:flutter/material.dart';

class ProductDeliveryScreen extends StatelessWidget {
  // Example data for a product delivery (replace with your data)
  final String productName = 'Product 1';
  final String productImage = 'asset/images/vans old skool.png';
  final String deliveryStatus = 'Out for Delivery';
  final String estimatedDeliveryDate = '2023-07-05';
  final String trackingNumber = '1234567890';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Status'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Center(
              child: Image.asset(
                productImage,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            // Product Name
            Text(
              productName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Delivery Status
            Text(
              'Delivery Status: $deliveryStatus',
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            // Estimated Delivery Date
            Text(
              'Estimated Delivery Date: $estimatedDeliveryDate',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            // Tracking Number
            Text(
              'Tracking Number: $trackingNumber',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            // Progress Bar
            _buildProgressBar(),
            SizedBox(height: 20),
            // Delivery Steps
            _buildDeliverySteps(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: LinearProgressIndicator(
        value: 0.75, // Example progress value (75% complete)
        backgroundColor: Colors.grey[300],
        color: Colors.green,
        minHeight: 10,
      ),
    );
  }

  Widget _buildDeliverySteps() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStep(
          step: 'Order Placed',
          date: '2023-07-01',
          isCompleted: true,
        ),
        _buildStep(
          step: 'Order Processed',
          date: '2023-07-02',
          isCompleted: true,
        ),
        _buildStep(
          step: 'Shipped',
          date: '2023-07-03',
          isCompleted: true,
        ),
        _buildStep(
          step: 'Out for Delivery',
          date: '2023-07-04',
          isCompleted: true,
        ),
        _buildStep(
          step: 'Delivered',
          date: '2023-07-05',
          isCompleted: false,
        ),
      ],
    );
  }

  Widget _buildStep({required String step, required String date, required bool isCompleted}) {
    return ListTile(
      leading: Icon(
        isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
        color: isCompleted ? Colors.green : Colors.grey,
      ),
      title: Text(step),
      subtitle: Text(date),
    );
  }
}
