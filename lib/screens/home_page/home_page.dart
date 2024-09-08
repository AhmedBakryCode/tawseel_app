import 'package:flutter/material.dart';
import 'package:task/screens/chats/chat_screen.dart';
import 'package:task/screens/chats/users_list_pge.dart';
import 'package:task/screens/settings/childern_setting.dart';
import 'package:task/screens/settings/settings_page.dart';
import 'package:task/screens/student/student_course_page.dart';

import '../../components/default_appbar.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  bool _showAllSubjects = false; // Flag to show all subjects
  bool _showAllNotices = false; // Flag to show more notices

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UsersListPage()));
        },
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Color(0xFF182243),
          child: Icon(
            Icons.chat_rounded,
            color: Colors.white,
          ),
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
                  Spacer(flex: 1),
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ChildernSettingsPage()));
                      },
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 30,
                      ))
                ],
              ),
            ),
            SizedBox(height: 20),
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
            // Subjects Section
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subjects',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _showAllSubjects = !_showAllSubjects;
                        });
                      },
                      child: Text(
                        _showAllSubjects ? "Show less" : "View all",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SubjectsGrid(itemCount: _showAllSubjects ? subjects.length : 3),
            SizedBox(height: 20),
            // Latest Notices Section
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Latest Notices',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _showAllNotices = !_showAllNotices;
                        });
                      },
                      child: Text(
                        _showAllNotices ? "Show less" : "View all",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ListView for cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: List.generate(
                    _showAllNotices ? 10 : 3, (index) {
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

  Widget _buildListCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChatPage()));
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
