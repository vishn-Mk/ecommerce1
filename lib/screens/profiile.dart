import 'package:ecommerce/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'complaint.dart';
import 'edit profile.dart';
import 'login.dart';
import 'orderhistory.dart';
import 'review.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'Vishnu';
  String email = 'vishnu@gmail.com';
  String phoneNumber = '7356735648';
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

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

  Future<void> _pickProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
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
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: const Text(
            "Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              color: Colors.black,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar(),));

          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
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
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: _pickProfileImage,
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
                        radius: 45,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : AssetImage('asset/images/profile1.jpg') as ImageProvider,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickProfileImage,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                name,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: Text(
                email,
                style: TextStyle(fontSize: 16, color: Colors.grey[500]),
              ),
            ),
            SizedBox(height: 20),
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
            Center(
              child: ElevatedButton(
                onPressed: _confirmLogout,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
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
