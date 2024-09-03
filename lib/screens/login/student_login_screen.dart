import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task/components/default_buttom.dart';
import 'package:task/components/default_textform_field.dart';
import 'package:task/screens/forget_password/forget_password_page.dart';
import 'package:task/screens/login/parent_login_screen.dart';
import 'package:task/screens/register_page/sign_up_page.dart';

import '../home_page/home_page.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({Key? key}) : super(key: key);

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          // Positioned images
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/top_right.png',
              width: 150,
              height: 150,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
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
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    isPassword: true,
                    controller: passwordController,
                    hintText: 'Password',
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
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
                          style: TextStyle(color: Colors.black),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpPage()),
                              );
                            },
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StudentHomePage()),
                      );
                    },
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
        ],
      ),
    );
  }
}
