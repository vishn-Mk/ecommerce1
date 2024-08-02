import 'package:ecommerce/screens/success.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int value = 0;
  final paymentLabels = [
    "Credit Card / Debit Card",
    "Cash on Delivery",
    "Paypal",
    "Google Wallet",
  ];

  final paymentIcons = [
    Icons.credit_card,
    Icons.money_off,
    Icons.payment,
    Icons.account_balance_wallet,
  ];

  final TextEditingController _upiController = TextEditingController();

  @override
  void dispose() {
    _upiController.dispose();
    super.dispose();
  }

  void _showUPIDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter UPI ID'),
          content: TextField(
            controller: _upiController,
            decoration: InputDecoration(
              hintText: 'Enter your UPI ID',
            ),
          ),
          actions: [
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[900]),
              onPressed: () {
                if (_upiController.text.isNotEmpty) {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Success()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('UPI ID cannot be empty')),
                  );
                }
              },
              child: Text('Pay',style: TextStyle(color: Colors.black),),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Payment",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Choose Your Payment Method",
              style: TextStyle(fontSize: 10),
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Radio(
                    activeColor: Colors.cyan,
                    value: index,
                    groupValue: value,
                    onChanged: (i) => setState(() => value = i!),
                  ),
                  title: Text(paymentLabels[index]),
                  trailing: Icon(paymentIcons[index], color: Colors.cyan),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: paymentLabels.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _showUPIDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: kprimaryColor,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 83),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  'Pay',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
