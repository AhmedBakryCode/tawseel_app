import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/components/default_buttom.dart';
import 'package:task/components/default_textform_field.dart';
import 'package:task/screens/home_page/home_page.dart';
import 'package:task/screens/home_page/parent_home_page.dart';
import 'package:task/screens/login/parent_login_screen.dart';
import 'package:task/services/auth_services.dart';
import 'package:task/services/otp_services.dart'; // Import your OTP service

class OTPPage extends StatefulWidget {
  final String phoneNumber;
  final String address;
  final String password;
  final String email;
final String name;
final String role;

  const OTPPage({Key? key, required this.phoneNumber, required this.address, required this.password, required this.email, required this.name, required this.role}) : super(key: key);

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final TextEditingController _otpController = TextEditingController();
  final OTPService _otpService = OTPService();
  String? verificationId;

  @override
  void initState() {
    super.initState();
    sendOTP();
  }
final AuthService _authService=AuthService();
  void sendOTP() async {
    try {
      await _otpService.sendOTP(widget.phoneNumber);
      // Save verificationId if needed in the service
      // You can set verificationId as a class variable if you want
    } catch (e) {
      // Handle errors (e.g., show a Snackbar with the error message)
      print("Failed to send OTP: $e");
    }
  }
String? _verificationId;

  void verifyOTP() async {
    if (_verificationId != null) {
      User? user = await AuthService().verifyOtp(
          _verificationId!, _otpController.text.trim());
      if (user != null) {
        print("OTP verified successfully! User: ${user.uid}");
      }
      else {
        print("Verification ID is null. Please request an OTP first.");
      }
      await _authService.registerUser(
        widget.email,
        widget.password,
        widget.phoneNumber,
        widget.address,
        widget.name,
        widget.role,
      );
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ParentHomePage(parendId: user!.uid)));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "OTP",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 50,
              color: Color(0xff222222),
            ),
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            isPassword: false,
            controller: _otpController,
            hintText: "Enter OTP",
          ),
          const SizedBox(height: 10),
          CustomButton(
            text: "VERIFY",
            onPressed: verifyOTP, // Call the verify function
          ),
        ],
      ),
    );
  }
}
