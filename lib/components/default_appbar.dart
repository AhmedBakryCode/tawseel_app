import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Widget centerWidget;

  const CustomAppBar({Key? key, required this.centerWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fill the screen width
      height: 140,
      decoration: BoxDecoration(
        color: Color(0xFF182243), // Background color
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
      ),
      child: Stack(
        children: [
          // Image positioned at the top right
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/appbar.png', // Replace with your image path
              width: 200, // Adjust the width of the image as needed
              height: 200, // Adjust the height of the image as needed
            ),
          ),
          // Center widget
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: centerWidget,
            ),
          ),
        ],
      ),
    );
  }
}
