import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/models/assignments_model.dart';
import 'package:task/services/assignments_services.dart';

class AssignmentsPage extends StatelessWidget {
  final String studentId; // Add the student ID

  const AssignmentsPage({required this.studentId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assignmentService = AssignmentService();


    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              centerWidget: Text(
                "Assignments",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: TabBar(
                indicator: BoxDecoration(
                  color: Color(0xff182243),
                  borderRadius: BorderRadius.circular(12),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Container(
                    height: 50,
                    child: Center(child: Text("Assigned")),
                  ),
                  Container(
                    height: 50,
                    child: Center(child: Text("Submitted")),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Assignment>>(
                future: assignmentService.getAssignments(studentId), // Fetch assignments for the student
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading assignments'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No assignments available'));
                  } else {
                    final assignments = snapshot.data!;
                    return TabBarView(
                      children: [
                        AssignedListPage(assignments: assignments),
                        SubmittedPage(assignments: assignments),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );

  }

}
class SubmittedPage extends StatelessWidget {
  final List<Assignment> assignments;

  const SubmittedPage({required this.assignments, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final submittedAssignments =
    assignments.where((assignment) => assignment.isSubmitted).toList();

    return ListView.builder(
      itemCount: submittedAssignments.length,
      itemBuilder: (context, index) => CardList(assignment: submittedAssignments[index]),
    );
  }
}
class AssignedListPage extends StatelessWidget {
  final List<Assignment> assignments;

  const AssignedListPage({required this.assignments, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final unsubmittedAssignments =
    assignments.where((assignment) => !assignment.isSubmitted).toList();

    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            // Upload assignment logic here
          },
          child: Text("Upload Assignment Document"),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: unsubmittedAssignments.length,
            itemBuilder: (context, index) => CardList(assignment: unsubmittedAssignments[index]),
          ),
        ),
      ],
    );
  }
}
class CardList extends StatelessWidget {
  final Assignment assignment;

  const CardList({required this.assignment, super.key});

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
            assignment.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                assignment.fileName,
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
              Icon(
                Icons.drive_file_move_outline,
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}
