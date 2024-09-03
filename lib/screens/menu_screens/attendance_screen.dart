import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            centerWidget: Text(
              "Attendance",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.green,
                      ),
                      child: Stack(
                        children: [
                          Positioned(top: 0,right: 100,left: 100,child: Text("Total Present",style: TextStyle(color: Colors.white,fontSize: 20),)),
                          Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              child: Text(
                                "6",
                                style: TextStyle(
                                    fontSize: 50, color: Colors.green),
                              ),
                            ),
                          ),
                          Positioned(
                            child: Image.asset("assets/happy.png"),
                            bottom: 20,
                            right: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.red,
                      ),
                      child: Stack(
                        children: [
                          Positioned(top: 0,right: 100,left: 100,child: Text("Total Absent",style: TextStyle(color: Colors.white,fontSize: 20),)),

                          Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              child: Text(
                                "1",
                                style: TextStyle(
                                    fontSize: 50, color: Colors.red),
                              ),
                            ),
                          ),
                          Positioned(
                            child: Image.asset("assets/unhappy.png"),
                            bottom: 20,
                            left: 0,
                          ),
                        ],
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
  }
}
