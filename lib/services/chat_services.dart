import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/models/message_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream for fetching messages between two users
  Stream<List<Message>> messagesStream(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList();
    });
  }

  // Sending a message
  Future<void> sendMessage(String chatId, Message message) async {
    final messageDoc = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc();

    await messageDoc.set(message.toFirestore());
  }

  void dispose() {
    // Close any stream subscriptions if needed
  }
}
