import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/screens/chats/chat_screen.dart';

class TeacherPage extends StatelessWidget {
  const TeacherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(centerWidget: Text("Teachers",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w700),),)
          ,const SizedBox(height: 20,),

            ListView.builder(physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount: 10,itemBuilder: (context,index)=>
                Container(

                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(

                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(4, 4),
                    blurRadius: 4,
                  ),
                ],
                              ),
                              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/user.png', // Replace with your image asset path
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'MR: Mohamed',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Science Teacher'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage())),
                          icon: Icon(
                            Icons.message, // Replace with WhatsApp icon if needed
                            color: Color(0xff3A3A3A),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('0123456789'), // Replace with actual telephone number
                      ],
                    ),
                  ],
                ),
                              ),
                            ),
            )


          ],
        ),
      ),
    );
  }
}
