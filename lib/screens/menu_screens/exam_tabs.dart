import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task/models/exam_model.dart';
import 'package:task/screens/menu_screens/exam_screen.dart';

Future<List<ExamModel>> fetchExams(String studentId, String type) async {
  final QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('students') // Main student collection
      .doc(studentId) // Specific student document
      .collection('exams') // Sub-collection of exams
      .where('type', isEqualTo: type) // Filter based on exam type
      .get();

  return snapshot.docs
      .map((doc) => ExamModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
      .toList();
}
class OfflineExamPage extends StatelessWidget {
  final String studentId; // Pass studentId to fetch the specific student's exams

  OfflineExamPage({required this.studentId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ExamModel>>(
      future: fetchExams(studentId, 'Offline'), // Fetch offline exams for this student
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No offline exams found.'));
        }

        final exams = snapshot.data!;

        return ListView.builder(
          itemCount: exams.length,
          itemBuilder: (context, index) => ExamCardList(exam: exams[index]),
        );
      },
    );
  }
}

class OnlineExamPage extends StatelessWidget {
  final String studentId; // Pass studentId to fetch the specific student's exams

  OnlineExamPage({required this.studentId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ExamModel>>(
      future: fetchExams(studentId, 'Online'), // Fetch online exams for this student
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No online exams found.'));
        }

        final exams = snapshot.data!;

        return ListView.builder(
          itemCount: exams.length,
          itemBuilder: (context, index) => ExamCardList(exam: exams[index]),
        );
      },
    );
  }
}
class ExamCardList extends StatelessWidget {
  final ExamModel exam; // Pass exam model to the card

  const ExamCardList({Key? key, required this.exam}) : super(key: key);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  exam.name, // Display exam name
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  exam.date, // Display exam date
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  exam.type, // This can be updated based on your data structure
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                Text(
                  exam.time, // Display exam time
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
