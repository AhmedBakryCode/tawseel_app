import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel {
  String messageId;
  String message;
  String receiverId;
  String senderId;
  String senderEmail;
  DateTime timestamp;

  ChatMessageModel({
    required this.messageId,
    required this.message,
    required this.receiverId,
    required this.senderId,
    required this.senderEmail,
    required this.timestamp,
  });

  // Factory method to convert from Firestore document
  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      messageId: map['messageId'],
      message: map['message'],
      receiverId: map['receiverId'],
      senderId: map['senderId'],
      senderEmail: map['senderEmail'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  // Method to convert to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'message': message,
      'receiverId': receiverId,
      'senderId': senderId,
      'senderEmail': senderEmail,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
