import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: [
                CustomAppBar(
                  centerWidget: Text(
                    "Exam",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                ListView.builder(physics: NeverScrollableScrollPhysics(),itemBuilder: (context,index)=> ResultCardList())
              ]),
        ));
  }}
class ResultCardList extends StatelessWidget {
  const ResultCardList({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(4, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  'Exam Name',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                ),
                Text(
                  '22-02-2024',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mid Term Math',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                Text(
                  'Pass',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),
                ),
              ],
            ),Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Grade',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                Text(
                  '90%',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
