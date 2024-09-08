import 'package:flutter/material.dart';
import 'package:task/components/default_buttom.dart';
import 'package:task/screens/home_page/parent_home_page.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 200,),
                Image.asset("assets/bags.png",height: MediaQuery.of(context).size.height*0.4,width: MediaQuery.of(context).size.width*0.8,),
               const Text("SUCCESS",style: TextStyle(fontSize: 34,fontWeight: FontWeight.w700),),
               const Text("Your Order Will Come To you soon ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                const Text("Thank you for choosing our app! ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),)
              ],
            ),
          ),
          const SizedBox(height: 30,),
          CustomButton(text: "CONTINUE", onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>ParentHomePage()  ));})
        ],
      ),
    );
  }
}
