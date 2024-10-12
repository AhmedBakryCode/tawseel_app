import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task/components/default_buttom.dart';
import 'package:task/components/default_textform_field.dart';
import 'package:task/screens/forget_password/forget_password_page.dart';
import 'package:task/screens/home_page/home_page.dart';
import 'package:task/screens/login/parent_login_screen.dart';
import 'package:task/screens/register_page/sign_up_page.dart';
import 'package:task/services/auth_services.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({Key? key}) : super(key: key);

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final AuthService _authServices =AuthService();
  void _submitForm() async{
    if (_formKey.currentState!.validate()) {
      try {
        // Use the AuthService to log in the user and get the user object
        UserCredential userCredential = await _authServices.loginUser(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        // Get the user ID from the UserCredential
        String userId = userCredential.user!.uid;

        // Navigate to ParentHomePage with the userId parameter
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentHomePage( studentId: userId,),
          ),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${error.toString()}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fix the errors in red')),
      );    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Positioned images using Align and FractionalOffset
            Align(
              alignment: FractionalOffset.topRight,
              child: Image.asset(
                'assets/top_right.png',
                width: 150,
                height: 150,
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomLeft,
              child: Image.asset(
                'assets/buttom_left.png',
                width: 150,
                height: 150,
              ),
            ),
            // Scrollable content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey, // Add Form key for validation
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 100), // Space to push content below top image
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      CustomTextFormField(
                        isPassword: false,
                        controller: emailController,
                        hintText: 'Email',
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          }
                          String emailPattern =
                              r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
                          if (!RegExp(emailPattern).hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        isPassword: true,
                        controller: passwordController,
                        hintText: 'Password',
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          if (!RegExp(r'[0-9]').hasMatch(value)) {
                            return 'Password must contain at least one number';
                          }
                          if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
                            return 'Password must contain at least one special character';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ForgetPasswordPage()),
                              );
                            },
                            child: Text(
                              'Forgot your password?',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          SizedBox(height: 10),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Don't have an account? ",
    recognizer: TapGestureRecognizer()
    ..onTap = () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpPage()),
      );
    },
    style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: 'Student?',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ParentLoginScreen()),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      CustomButton(
                        text: "LOGIN",
                        onPressed: _submitForm,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Management Education Serves And Buses At Your Home',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 50), // Space to push content above bottom image
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
