import 'package:flutter/material.dart';
import 'package:task/screens/login/parent_login_screen.dart';
import 'package:task/screens/login/student_login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // First layer: Image with background color
          Container(
            color: Color(0xFF182243),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/Group 1.png', // Replace with your image asset path
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(), // Placeholder for the second half
                ),
              ],
            ),
          ),
          // Second layer: Container with content
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              padding: EdgeInsets.all(20.0),
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'School Services At Your Home',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF182243),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Management Education Services\nAnd Buses At Your Home',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF182243),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentLoginScreen()));

                    },
                    style: ElevatedButton.styleFrom(

                      primary: Color(0xFF182243),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 35.0),
                    ),
                    child: Text(
                      'LOGIN AS STUDENT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=> ParentLoginScreen()));                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF182243),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 35.0),
                    ),
                    child: Text(
                      'LOGIN AS PARENT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }}
