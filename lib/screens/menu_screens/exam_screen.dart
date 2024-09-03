import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';

class ExamPage extends StatelessWidget {
  const ExamPage({Key? key}) : super(key: key);

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
                  OfflineExamPage(),
                  OnlineExamPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OfflineExamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Replace with the actual number of items
      itemBuilder: (context, index) => ExamCardList(),
    );
  }
}

class OnlineExamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Replace with the actual number of items
      itemBuilder: (context, index) => ExamCardList(),
    );
  }
}

class ExamCardList extends StatelessWidget {
  const ExamCardList({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(4, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  'Exam Name',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                ),
                Text(
                  '22-02-2024',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mid Year',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                Text(
                  '09: 15 AM',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
