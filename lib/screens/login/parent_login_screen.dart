import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task/components/default_buttom.dart';
import 'package:task/components/default_textform_field.dart';
import 'package:task/screens/forget_password/forget_password_page.dart';
import 'package:task/screens/home_page/parent_home_page.dart';
import 'package:task/screens/settings/profile_page.dart';
import 'package:task/screens/student/student_course_page.dart';

class ParentLoginScreen extends StatefulWidget {
  const ParentLoginScreen({Key? key}) : super(key: key);

  @override
  State<ParentLoginScreen> createState() => _ParentLoginScreenState();
}

class _ParentLoginScreenState extends State<ParentLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
     _submitForm() {
      if (_formKey.currentState!.validate()) {
        // Form is valid, proceed with submission
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ParentHomePage()),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fix the errors in red')),
        );
      }
    }
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Positioned images using Align and FractionalOffset
            Align(
              alignment: FractionalOffset.topRight,
              child: Image.asset(
                'assets/top_right2.png',
                width: 150,
                height: 150,
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomLeft,
              child: Image.asset(
                'assets/buttom_left2.png',
                width: 150,
                height: 150,
              ),
            ),
            Align(
              alignment: FractionalOffset.topLeft,
              child: Image.asset(
                'assets/top_left.png',
                width: 250,
                height: 500,
              ),
            ),

            // Scrollable content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
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
                        validator: (String value) {
                          // Check if the email is empty
                          if (value.isEmpty) {
                            return 'Email is required';
                          }

                          // Regular expression for validating an email
                          String emailPattern =
                              r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
                          RegExp regExp = RegExp(emailPattern);

                          if (!regExp.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }

                          return null; // Return null if the email is valid
                        },
                        isPassword: false,
                        controller: emailController,
                        hintText: 'Email',
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(validator: (String value) {
                        // Check if the password is empty
                        if (value.isEmpty) {
                          return 'Password is required';
                        }

                        // Minimum password length
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }

                        // Check for at least one digit
                        if (!RegExp(r'[0-9]').hasMatch(value)) {
                          return 'Password must contain at least one number';
                        }

                        // Check for at least one special character
                        if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
                          return 'Password must contain at least one special character';
                        }

                        return null; // Return null if the password is valid
                      },
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
                          _submitForm();
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
            ),
          ],
        ),
      ),
    );
  }
}
