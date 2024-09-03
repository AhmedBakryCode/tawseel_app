import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task/components/default_buttom.dart';
import 'package:task/components/default_textform_field.dart';
import 'package:task/screens/chats/users_list_pge.dart';
import 'package:task/screens/forget_password/forget_password_page.dart';
import 'package:task/screens/home_page/home_page.dart';
import 'package:task/screens/home_page/parent_home_page.dart';
import 'package:task/screens/login/parent_login_screen.dart';
import 'package:task/screens/menu_screens/assignments_screen.dart';
import 'package:task/screens/menu_screens/attendance_screen.dart';
import 'package:task/screens/menu_screens/exam_screen.dart';
import 'package:task/screens/menu_screens/result_screen.dart';
import 'package:task/screens/menu_screens/teachers_screen.dart';
import 'package:task/screens/menu_screens/time_table.dart';
import 'package:task/screens/register_page/sign_up_page.dart';

import '../student/student_course_page.dart';

class ParentLoginScreen extends StatefulWidget {
  const ParentLoginScreen({Key? key}) : super(key: key);

  @override
  State<ParentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<ParentLoginScreen> {
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
              'assets/top_right2.png',
              width: 150,
              height: 150,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/buttom_left2.png',
              width: 150,
              height: 150,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/top_left.png',
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
                    ],
                  ),
                  SizedBox(height: 10),
                  CustomButton(
                    text: "LOGIN",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ParentHomePage()),
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
