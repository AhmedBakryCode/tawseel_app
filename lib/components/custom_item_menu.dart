
import 'package:flutter/material.dart';

class CustomMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const CustomMenuItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
     // height: 60,
      //width: 300,

      decoration: BoxDecoration(
      border: Border.all(
      color: Color(0xff182243),),
      borderRadius: BorderRadius.circular(15),
        shape: BoxShape.rectangle,
      ),
      child: ListTile(
        trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff182243)),
        leading: CircleAvatar(
          radius: 30,
          child: Icon(icon, size: 30, color: Colors.white),
          backgroundColor: Color(0xff182243),
        ),
        title: Text(title),
      ),
    );
  }
}