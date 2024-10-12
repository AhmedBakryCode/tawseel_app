import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/models/assignments_model.dart';

class AssignmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all assignments for a student from Firestore
  Future<List<Assignment>> getAssignments(String studentId) async {
    try {
      // Access the student's assignments collection
      final snapshot = await _firestore
          .collection('users')
          .doc(studentId)
          .collection('assignments')
          .get();

      // Map the fetched documents to Assignment models
      return snapshot.docs.map((doc) => Assignment.fromMap(doc.data())).toList();
    } catch (e) {
      print('Error fetching assignments: $e');
      throw Exception('Error fetching assignments');
    }
  }

// Add more functions for submitting assignments if needed
}
