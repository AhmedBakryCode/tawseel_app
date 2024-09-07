import 'package:flutter/material.dart';
import 'package:task/screens/chats/chat_screen.dart';
import 'package:task/screens/chats/users_list_pge.dart';
import 'package:task/screens/settings/settings_page.dart';
import 'package:task/screens/student/student_course_page.dart';

import '../../components/default_appbar.dart';

class ParentHomePage extends StatelessWidget {
  const ParentHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersListPage()));
        },
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Color(0xFF182243),
          child: Icon(Icons.chat_rounded, color: Colors.white,),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              centerWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Spacer(flex: 1,),
                  IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));}, icon: Icon(Icons.settings,color: Colors.white,size: 30,))
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 180,
              child: PageView(
                children: [
                  _buildImagePage('assets/Rectangle 9.png'),
                  _buildImagePage('assets/Rectangle 9.png'),
                  _buildImagePage('assets/Rectangle 9.png'),
                ],
              ),
            ),
            SizedBox(height: 20),

            // 3. GridView for "MY Children"
            Align(alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'MY Children',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(), // Disable grid scrolling
                shrinkWrap: true, // Wrap the grid to its content size
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return _buildChildCard(context);
                },
              ),
            ),
            SizedBox(height: 20),
            Align(alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Latest Noticies',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // 4. ListView for cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: List.generate(4, (index) {
                  return _buildListCard(context);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePage(String imagePath) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      width: 355,
    );
  }

  Widget _buildChildCard(BuildContext context, ) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => StudentCoursePage()));
      },
      child: Container(
        height: 80,
        width: 164,
        decoration: BoxDecoration(
          color: Color(0xFF182243),
          borderRadius: BorderRadius.circular(21),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/user.png', height: 50, width: 50),
            SizedBox(height: 10),
            Text(
              'Ahmed',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'Level 2',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildListCard(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));

      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MR: Adel',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Science Teacher Ahmed'),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Message',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Management Education Services'),
                  Text('Buses At Your Home'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
