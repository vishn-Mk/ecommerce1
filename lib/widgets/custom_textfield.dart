import 'package:flutter/material.dart';

class custom_textfeild extends StatefulWidget {
  final String labeltext;
  final bool obscuretext;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const custom_textfeild({
    super.key,
    required this.labeltext,
    this.obscuretext = true,
    this.isPassword = false,
    this.controller,
    this.validator,
  });

  @override
  State<custom_textfeild> createState() => _custom_textfeildState();
}

class _custom_textfeildState extends State<custom_textfeild> {
  bool _obscuretext = true;

  @override
  void initState() {
    super.initState();
    _obscuretext = widget.obscuretext;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscuretext : false,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.labeltext,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        fillColor: Colors.white,
        filled: true,
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscuretext ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscuretext = !_obscuretext;
            });
          },
        )
            : null,
      ),
    );
  }
}