import 'package:flutter/material.dart';
import 'package:task/models/message_model.dart';
import 'package:task/models/teacher_model.dart';
import 'package:task/services/chat_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';

class ChatPage extends StatefulWidget {
  final TeacherModel teacher;

  const ChatPage({Key? key, required this.teacher}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void dispose() {
    _messageController.dispose();
    _chatService.dispose();
    super.dispose();
  }

  // Replace with actual logic to get the chatId
  String getChatId() {
    return "${currentUserId}_${widget.teacher.teacherId}";
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      Message message = Message(
        senderId: currentUserId,
        receiverId: widget.teacher.teacherId,
        text: _messageController.text,
        timestamp: DateTime.now(),
      );
      _chatService.sendMessage(getChatId(), message);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.teacher.teacherName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _chatService.messagesStream(getChatId()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!;
                  return ListView.builder(
                    reverse: true, // Show the latest messages at the bottom
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      bool isSender = message.senderId == currentUserId;
                      return isSender
                          ? BubbleSpecialThree(
                        text: message.text,
                        color: Colors.green,
                        tail: true,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )
                          : BubbleSpecialOne(
                        text: message.text,
                        isSender: false,
                        color: Colors.grey,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _messageController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFE1DDDD),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                prefixIcon: IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: () {
                    // Action for inserting files
                  },
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Type a message...',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
