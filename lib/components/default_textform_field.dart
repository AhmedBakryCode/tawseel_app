import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final bool isPassword;
  final TextEditingController controller;
  final String hintText;

  CustomTextFormField({
    required this.isPassword,
    required this.controller,
    required this.hintText,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();

    // Listen to changes in the text field to update the icon
    widget.controller.addListener(() {
      setState(() {
        _isValid = widget.controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xFFF8F3F1), // Background color
        //borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 4), // Drop shadow from the Y-axis
            blurRadius: 4,
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : Icon(
            _isValid ? Icons.check_circle : Icons.email,
            color: _isValid ? Colors.green : Colors.grey,
          ),
        ),
      ),
    );
  }
}
