import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';

class AssignmentsPage extends StatelessWidget {
  const AssignmentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              centerWidget: Text(
                "Assignment",
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
                    child: Center(child: Text("Assigned")),
                  ),
                  Container(
                    height: 50, // Set the height of the tab
                    child: Center(child: Text("Submitted")),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AssignedListPage(),
                  SubmittedPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubmittedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Replace with the actual number of items
      itemBuilder: (context, index) => CardList(),
    );
  }
}

class AssignedListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Replace with the actual number of items
      itemBuilder: (context, index) => CardList(),
    );
  }
}

class CardList extends StatelessWidget {
  const CardList({
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
        Text(
        'Assignments',
        style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text(
        'intro to chapter 3.pdf',
        style: TextStyle(color: Colors.black, fontSize: 10),
        ),
        Icon(
        Icons.drive_file_move_outline,
        color: Colors.black,
        )
        ],
        ),
        ],
        ),
        ),
        );
  }
}
