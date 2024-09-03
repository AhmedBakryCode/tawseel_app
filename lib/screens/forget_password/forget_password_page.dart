
import 'package:flutter/material.dart';

import '../../components/default_buttom.dart';
import '../../components/default_textform_field.dart';
import '../home_page/home_page.dart';

class ForgotPasswordScreen extends StatefulWidget {
@override
_ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
final TextEditingController phoneController = TextEditingController();
final TextEditingController otpController = TextEditingController();

@override
void dispose() {
phoneController.dispose();
otpController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.white,
body: Padding(
padding: const EdgeInsets.symmetric(horizontal: 20),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text(
"Forgot password",
style: TextStyle(
fontSize: 28,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 30),
CustomTextFormField(
controller: phoneController,
isPassword: false,
hintText: "Please, enter your phone number",
),
SizedBox(height: 20),
CustomButton(
text: "SEND",
onPressed: () {
  Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentHomePage()));
},
),
SizedBox(height: 20),
CustomTextFormField(
controller: otpController,
isPassword: false,
hintText: "Please, enter OTP code",
),
SizedBox(height: 20),
CustomButton(
text: "LOGIN",
onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentHomePage()));
  },
),
],
),
),
);
}
}