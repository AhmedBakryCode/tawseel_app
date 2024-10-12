import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/screens/menu_screens/exam_tabs.dart';

class ExamPage extends StatelessWidget {
  final String studentId; // Pass studentId here

  ExamPage({required this.studentId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              centerWidget: Text(
                "Exam",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              color: Colors.white, // Tabs' background color
              child: TabBar(
                indicator: BoxDecoration(
                  color: Color(0xff182243), // Color for the selected tab
                  borderRadius: BorderRadius.circular(12), // Rounded corners for the selected tab
                ),
                labelColor: Colors.white, // Text color for the selected tab
                unselectedLabelColor: Colors.black, // Text color for the unselected tabs
                tabs: [
                  Container(
                    height: 50, // Set the height of the tab
                    child: Center(child: Text("Offline")),
                  ),
                  Container(
                    height: 50, // Set the height of the tab
                    child: Center(child: Text("Online")),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  OfflineExamPage(studentId: studentId), // Pass studentId to Offline exams
                  OnlineExamPage(studentId: studentId), // Pass studentId to Online exams
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
