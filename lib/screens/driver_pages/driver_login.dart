import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task/components/default_buttom.dart';
import 'package:task/components/default_textform_field.dart';
import 'package:task/screens/driver_pages/driver_home_page.dart';
import 'package:task/screens/forget_password/forget_password_page.dart';
import 'package:task/screens/home_page/parent_home_page.dart';
import 'package:task/screens/login/student_login_screen.dart';
import 'package:task/screens/register_page/sign_up_page.dart';
import 'package:task/services/auth_services.dart';

class DriverLoginScreen extends StatefulWidget {
  const DriverLoginScreen({Key? key}) : super(key: key);

  @override
  State<DriverLoginScreen> createState() => _ParentLoginScreenState();
}

class _ParentLoginScreenState extends State<DriverLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _authServices =AuthService();
  void _submitForm() async{
    if (_formKey.currentState!.validate()) {
      await _authServices.loginUser(emailController.toString(), passwordController.toString());

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DriverHomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fix the errors in red')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _buildBackgroundImages(), // Reusable function to handle images
            _buildLoginForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImages() {
    return Stack(
      children: [
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
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 100),
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
                controller: emailController,
                hintText: 'Email',
                validator: (value) {
                  if (value!.isEmpty) return 'Email is required';
                  if (!RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$').hasMatch(value))
                    return 'Enter a valid email address';
                  return null;
                }, isPassword: false,
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: passwordController,
                isPassword: true,
                hintText: 'Password',
                validator: (value) {
                  if (value!.isEmpty) return 'Password is required';
                  if (value.length < 8) return 'Password must be at least 8 characters long';
                  if (!RegExp(r'[0-9]').hasMatch(value)) return 'Password must contain at least one number';
                  if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) return 'Password must contain at least one special character';
                  return null;
                },
              ),
              SizedBox(height: 10),
              _buildFooterOptions(context),
              SizedBox(height: 30),
              CustomButton(
                text: "LOGIN",
                onPressed: _submitForm,
              ),
              SizedBox(height: 10),
              SizedBox(height: 20),
              Text(
                'Management Education Serves And Buses At Your Home',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterOptions(BuildContext context) {
    return Column(
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
      ],
    );
  }


}
