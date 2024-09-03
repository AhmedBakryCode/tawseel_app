import 'package:flutter/material.dart';
import 'package:task/screens/forget_password/otp_page.dart';

import '../../components/default_buttom.dart';
import '../../components/default_textform_field.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Text(
              "Sign up",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            CustomTextFormField(
              controller: nameController,
              isPassword: false,
              hintText: "Name",
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: emailController,
              isPassword: false,
              hintText: "Email",
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: passwordController,
              isPassword: true,
              hintText: "Password",
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: addressController,
              isPassword: false,
              hintText: "Address",
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: phoneController,
              isPassword: false,
              hintText: "Phone",
            ),
            SizedBox(height: 30),
            CustomButton(
              text: "SIGN UP",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> OTPPage()));
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
