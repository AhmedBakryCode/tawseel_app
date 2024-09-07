import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/components/default_buttom.dart';
import 'package:task/screens/settings/payment_medthod.dart';

class MyCartPage extends StatelessWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: SingleChildScrollView(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomAppBar(centerWidget: Text("My Card",style:TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w700,
      ),)),
      ListView.builder(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemCount: 4,itemBuilder: (context,index)=> DefaultCartCard()),
      Align(alignment: Alignment.center,
        child: Text("Total Amount : 170\$",style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),),
      ),
      CustomButton(text: "Check Out", onPressed:  (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentMethod()) );}),
const SizedBox(height: 20,)
    ],
  ),
),
    );
  }
}
class DefaultCartCard extends StatelessWidget {
  const DefaultCartCard({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("Mahmoud",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Text("Nationality: egypt",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                ],
              ),
              Image.asset("assets/user.png",height: 100,width: 100,)
            ],
          ),
          Row(
            children: [
              Text("Level : First",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ],
          ),
          Row(
            children: [
              Text("Ammount : 112\$ ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ],
          ),
        ],
      ),
    );
  }
}
