import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/screens/chats/chat_screen.dart';
import 'package:task/screens/chats/users_list_pge.dart';
import 'package:task/screens/settings/childern_setting.dart';
import 'package:task/screens/student/student_course_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/models/teacher_model.dart';
import '../../components/default_appbar.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key, required this.studentId}) : super(key: key);

  final String studentId;

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  User? _user; // Firebase user object
  void _fetchUser() {
    // Fetch the current authenticated user
    setState(() {
      _user = FirebaseAuth.instance.currentUser;
    });
  }

  bool _showAllSubjects = false; // Flag to show all subjects
  bool _showAllNotices = false; // Flag to show more notices
@override
  void initState() {
  _fetchUser(); // Fetch the authenticated user when the widget is initialized

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=> UsersListPage()));
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
                          _user?.displayName ?? 'name', // Dynamic email display
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          _user?.email ?? 'guest@example.com', // Dynamic email display
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(flex: 1),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChildernSettingsPage(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
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
                child: Text(
                  'Subjects',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Implement your SubjectsGrid here
            SizedBox(height: 20),
            // Teachers List Section
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Available Teachers',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _buildTeachersList(context),
            SizedBox(height: 20),
            // Latest Notices Section
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Latest Notices',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Implement your notices here
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

  Widget _buildTeachersList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseFirestore.instance.collection('users').id)
          .collection('teachers')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text(
            'No Teachers Available',
            style: TextStyle(color: Colors.grey),
          );
        }

        var teachers = snapshot.data!.docs
            .map((doc) =>
            TeacherModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList();

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: teachers.length,
          itemBuilder: (context, index) {
            return _buildTeacherCard(context, teachers[index]);
          },
        );
      },
    );
  }

  Widget _buildTeacherCard(BuildContext context, TeacherModel teacher) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        // Navigate to ChatPage with the selected teacher
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              teacher: teacher,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10, left: 16, right: 16),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withOpacity(0.1)
                  : Colors.black.withOpacity(0.1),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xff182243),
              radius: 30,
              child: Image.asset("assets/user.png"),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MR: ${teacher.teacherName}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    'Subject: ${teacher.subjectName}',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    'Phone: ${teacher.mobilePhone}',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.chat),
              color: Color(0xff182243),
              onPressed: () {
                // Navigate to ChatPage with the selected teacher
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      teacher: teacher,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
