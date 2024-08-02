import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const CustomButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text('Sign Up For Free', style: TextStyle(color: Colors.black)),
    );
  }
}