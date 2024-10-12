import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherModel {
  String teacherId;
  String subjectName;
  String teacherName;
  String mobilePhone;
  DateTime chatDate;

  TeacherModel({
    required this.teacherId,
    required this.subjectName,
    required this.teacherName,
    required this.mobilePhone,
    required this.chatDate,
  });

  // Factory method to convert from Firestore document
  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      teacherId: map['teacherId'],
      subjectName: map['subjectName'],
      teacherName: map['teacherName'],
      mobilePhone: map['mobilePhone'],
      chatDate: (map['chatDate'] as Timestamp).toDate(),
    );
  }

  // Method to convert to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'teacherId': teacherId,
      'subjectName': subjectName,
      'teacherName': teacherName,
      'mobilePhone': mobilePhone,
      'chatDate': Timestamp.fromDate(chatDate),
    };
  }
}
