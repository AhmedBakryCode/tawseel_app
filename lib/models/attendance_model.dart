import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  String studentId;
  String studentName;
  bool isPresent;

  AttendanceModel({
    required this.studentId,
    required this.studentName,
    required this.isPresent,
  });

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      studentId: map['studentId'],
      studentName: map['studentName'],
      isPresent: map['isPresent'],
    );
  }
}
