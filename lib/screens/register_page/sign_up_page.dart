import 'package:flutter/material.dart';
import 'package:task/components/default_buttom.dart';
import 'package:task/screens/forget_password/otp_page.dart';
import 'package:task/services/auth_services.dart';
import '../../components/default_textform_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }
String? _verificationId;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
  void sendOtp() {
    AuthService().sendOtp(

      phoneController.text.trim(),
          (PhoneAuthCredential credential) {
        // Auto-complete verification
        showSnackBar("Verification completed: $credential");
      },
          (FirebaseAuthException e) {
        // Handle failure
        print("Verification failed: ${e.message}");
      },
          (String verificationId, int? resendToken) {
        // Store verification ID to verify OTP later
        _verificationId = verificationId;
        print("OTP sent to phone: $verificationId");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var _role= "student";
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
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
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Role'),
                value: _role= "student",
                onChanged: (val) => setState(() => _role = val!),
                items: ['student', 'teacher', 'parent', 'driver'].map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
              ),

              isLoading
                  ? CircularProgressIndicator()
                  : CustomButton(
                text: "SIGN UP",
                onPressed: () async {
              if (_formKey.currentState!.validate()) {
              sendOtp();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPPage(role: _role,name: nameController.toString(),password: passwordController.toString(),phoneNumber: phoneController.toString(),email: emailController.toString(),address: addressController.toString())));
              }},
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),

    );

  }

}
