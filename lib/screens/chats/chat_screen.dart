import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(
                    centerWidget: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xff182243),
                          radius: 30,
                          child: Image.asset("assets/user.png"),
                        ),
                        SizedBox(width: 10),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Mohamed",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "mohamed@gmail.com",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Text("May 28")
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  SizedBox(height: 10),
                  BubbleSpecialThree(
                    text: 'Please try and give some feedback on it!',
                    color: Colors.grey,
                    tail: true,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  BubbleSpecialOne(
                    text: 'Hi, How are you?',
                    isSender: false,
                    color: Colors.green,
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
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
                  onPressed: () {
                    // Action for sending the message
                  },
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
