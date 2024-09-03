import 'package:flutter/material.dart';

import '../../components/default_buttom.dart';
import '../../components/default_textform_field.dart';
import '../home_page/home_page.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _otpcontroller= TextEditingController();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("OTP", style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 50,
            color: Color(0xff222222),
          ),),
          const  SizedBox(height: 20,),
          CustomTextFormField(isPassword: false, controller: _otpcontroller, hintText: "OTP"),
          const SizedBox(height: 10,),
          CustomButton(text: "LOGIN", onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentHomePage()));
          })
        ],
      ),
    );
  }
}
