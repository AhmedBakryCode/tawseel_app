import 'package:cloud_firestore/cloud_firestore.dart';

class Result {
  final String examName;  // Name of the exam
  final String date;      // Date of the exam
  final String grade;     // Grade achieved
  final String percentage; // Percentage achieved
  final String state;     // Pass/Fail state
  final String type;      // Type of exam (e.g., mid-term, final, etc.)

  Result({
    required this.examName,
    required this.date,
    required this.grade,
    required this.percentage,
    required this.state,
    required this.type,
  });

  // Factory constructor for creating a Result from a Firestore document
  factory Result.fromDocument(DocumentSnapshot doc) {
    return Result(
      examName: doc['examName'] ?? '',  // Exam name from Firebase
      date: doc['date'] ?? '',          // Exam date
      grade: doc['grade'] ?? '',        // Grade received
      percentage: doc['Percentage'] ?? '',  // Percentage score
      state: doc['state'] ?? '',        // State (pass/fail)
      type: doc['type'] ?? '',          // Exam type
    );
  }
}
