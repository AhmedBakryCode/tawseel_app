import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userId;
  String userType;
  String name;
  String email;
  String phone;
  String? address; // Optional for teachers and drivers
  String? parentId; // For students
  String? studentId; // For students (6-digit)
  String? subject; // For teachers
  String? mobilePhone; // For teachers
  String? busNumber; // For drivers
  String? routeDetails; // For drivers
  DateTime createdAt;
  DateTime lastLogin;

  UserModel({
    required this.userId,
    required this.userType,
    required this.name,
    required this.email,
    required this.phone,
    this.address,
    this.parentId,
    this.studentId,
    this.subject,
    this.mobilePhone,
    this.busNumber,
    this.routeDetails,
    required this.createdAt,
    required this.lastLogin,
  });

  // Factory method to convert from Firestore document
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      userType: map['userType'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      parentId: map['parentId'],
      studentId: map['studentId'],
      subject: map['subject'],
      mobilePhone: map['mobilePhone'],
      busNumber: map['busNumber'],
      routeDetails: map['routeDetails'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      lastLogin: (map['lastLogin'] as Timestamp).toDate(),
    );
  }

  // Method to convert to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userType': userType,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'parentId': parentId,
      'studentId': studentId,
      'subject': subject,
      'mobilePhone': mobilePhone,
      'busNumber': busNumber,
      'routeDetails': routeDetails,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': Timestamp.fromDate(lastLogin),
    };
  }
}
