import 'package:ecommerce/screens/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'complaint.dart';
import 'edit profile.dart';

import 'login.dart';
import 'orderhistory.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'Vishnu';
  String email = 'vishnu@gmail.com';
  String phoneNumber = '7356735648';

  void _editProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(
          name: name,
          email: email,
          phoneNumber: phoneNumber,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        name = result['name'];
        email = result['email'];
        phoneNumber = result['phoneNumber'];
      });
    }
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout", style: TextStyle(fontSize: 16)),
          content: Text("Are you sure you want to log out?", style: TextStyle(fontSize: 14)),
          actions: [
            TextButton(
              child: Text("Cancel", style: TextStyle(fontSize: 14)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Logout", style: TextStyle(fontSize: 14)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[900],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: const Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle profile picture tap, e.g., show a larger view
                    },
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 45, // Slightly smaller radius for the profile picture
                        backgroundImage:
                        AssetImage('asset/images/profile1.jpg'),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    email,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Personal Information Section
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      'Personal Information',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: _editProfile,
                    ),
                  ),
                  Divider(),
                  _buildProfileItem('Name', name),
                  _buildProfileItem('Email', email),
                  _buildProfileItem('Phone Number', phoneNumber),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Order History Section
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      'Order History',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderHistoryScreen(),
                        ),
                      );
                    },
                  ),
                  Divider(),
                  _buildOrderItem(
                    'Product Name',
                    'Order Date: 2023-06-26\nStatus: Delivered',
                    'asset/images/women-shoes.png',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Complaints Section
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      'Complaints',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintRegisterScreen(),));
                    },
                  ),
                  Divider(),
                  _buildComplaintItem(
                    'Complaint ID: 12345',
                    'Status: Pending\nDetails: Issue with the product quality',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Reviews Section
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      'Reviews',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewAddScreen(),));
                    },
                  ),
                  Divider(),
                  _buildReviewItem(
                    'Product Name',
                    'Rating: ★★★★☆\nReview: Great product!',
                    'asset/images/women-shoes.png',
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Logout Button
            Center(
              child: ElevatedButton(
                onPressed: _confirmLogout,
                style: ElevatedButton.styleFrom(
                  padding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String title, String subtitle) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14, // Smaller font size
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12, // Smaller font size
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildOrderItem(String title, String subtitle, String imageUrl) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25, // Smaller radius for the image
        backgroundImage: AssetImage(imageUrl),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14, // Smaller font size
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12, // Smaller font size
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildComplaintItem(String title, String subtitle) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14, // Smaller font size
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12, // Smaller font size
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildReviewItem(String title, String subtitle, String imageUrl) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25, // Smaller radius for the image
        backgroundImage: AssetImage(imageUrl),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14, // Smaller font size
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12, // Smaller font size
          color: Colors.black87,
        ),
      ),
    );
  }
}
