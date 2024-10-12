import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/components/default_buttom.dart';
import 'package:task/components/default_textform_field.dart';
import 'package:task/screens/home_page/parent_home_page.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  String _verificationId = "";
  bool _isOTPFieldVisible = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Phone number TextFormField
            CustomTextFormField(
              controller: _phoneController,
              isPassword: false,
              hintText: "Enter your phone number",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            // Button to send OTP
            CustomButton(
              text: "Send OTP",
              onPressed: _sendOTP,
            ),
            SizedBox(height: 32),

            // OTP TextFormField, only visible after OTP is sent
            if (_isOTPFieldVisible)
              CustomTextFormField(
                controller: _otpController,
                isPassword: false,
                hintText: "Enter the OTP",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the OTP';
                  }
                  return null;
                },
              ),
            SizedBox(height: 16),

            // Button to verify OTP and login
            if (_isOTPFieldVisible)
              CustomButton(
                text: "Login",
                onPressed: _verifyOTP,
              ),

            // Loading indicator while sending or verifying OTP
            if (_isLoading) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  // Method to send OTP
  void _sendOTP() async {
    setState(() {
      _isLoading = true;
    });

    String phone = _phoneController.text.trim();
    if (phone.isNotEmpty) {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+2$phone",  // Add country code, e.g., +2 for Egypt
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          UserCredential userCredential = await _auth.signInWithCredential(credential);
          String userId = userCredential.user?.uid ?? '';
          _navigateToHomePage(userId); // If auto-verification is successful
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Verification failed: ${e.message}")));
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _isLoading = false;
            _verificationId = verificationId;
            _isOTPFieldVisible = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("OTP Sent")));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter a valid phone number")));
    }
  }

  // Method to verify OTP
  void _verifyOTP() async {
    setState(() {
      _isLoading = true;
    });

    String otp = _otpController.text.trim();
    if (otp.isNotEmpty) {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );

      try {
        UserCredential userCredential = await _auth.signInWithCredential(credential);
        // Get the user ID and navigate to the home page
        String userId = userCredential.user?.uid ?? '';
        _navigateToHomePage(userId);
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid OTP")));
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter the OTP")));
    }
  }

  // Method to navigate to home page after OTP verification
  void _navigateToHomePage(String userId) {
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ParentHomePage(parendId: userId, )),);
  }
}
