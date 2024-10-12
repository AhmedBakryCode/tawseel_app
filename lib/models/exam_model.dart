// exam_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ExamModel {
  String id; // Unique identifier for the exam
  String name; // Name of the exam
  String date; // Date of the exam
  String type; // Type of the exam (Offline/Online)
  String time; // Time of the exam

  ExamModel({
    required this.id,
    required this.name,
    required this.date,
    required this.type,
    required this.time,
  });

  factory ExamModel.fromMap(Map<String, dynamic> map, String id) {
    return ExamModel(
      id: id,
      name: map['name'] ?? '',
      date: map['date'] ?? '',
      type: map['type'] ?? '',
      time: map['time'] ?? '',
    );
  }
}
