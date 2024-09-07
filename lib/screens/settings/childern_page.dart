import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';

class ChildernPage extends StatelessWidget {
  const ChildernPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomAppBar(centerWidget: Text("Childerns",style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
        )),
            ListView.builder(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemCount: 6,itemBuilder: (context, index)=>CardListItem() )
          ],
        ),
      ),
    );
  }
}
class CardListItem extends StatelessWidget {
  const CardListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return                 Container(

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/user.png', // Replace with your image asset path
                  width: 100,
                  height: 100,
                ),
                SizedBox(width: 10),
                Text(
                  'MR: Mohamed',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Level: First',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Text('ID: 5485355'), // Replace with actual telephone number
              ],
            ),
          ],
        ),
      ),
    )
    ;
  }
}
