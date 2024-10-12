import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/models/teacher_model.dart';
import 'package:task/screens/chats/chat_screen.dart';
import 'package:task/screens/chats/users_list_pge.dart';
import 'package:task/screens/settings/settings_page.dart';
import 'package:task/screens/student/student_course_page.dart';
import '../../components/default_appbar.dart';

class ParentHomePage extends StatelessWidget {
  ParentHomePage({Key? key, required this.parendId}) : super(key: key);
  final String parendId;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UsersListPage()));
        },
        child: CircleAvatar(
          radius: 20,
          backgroundColor: const Color(0xFF182243),
          child: const Icon(Icons.chat_rounded, color: Colors.white),
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
                    backgroundColor: const Color(0xff182243),
                    radius: 30,
                    child: Image.asset("assets/user.png"),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
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
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SettingsPage()));
                    },
                    icon: const Icon(Icons.settings, color: Colors.white, size: 30),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildImageSlider(),
            const SizedBox(height: 20),
            _buildChildrenSection(isDarkMode),
            const SizedBox(height: 20),
            _buildAvailableTeachersSection(isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSlider() {
    return SizedBox(
      height: 180,
      child: PageView(
        children: [
          _buildImagePage('assets/Rectangle 9.png'),
          _buildImagePage('assets/Rectangle 9.png'),
          _buildImagePage('assets/Rectangle 9.png'),
        ],
      ),
    );
  }

  Widget _buildImagePage(String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
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

  Widget _buildChildrenSection(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'MY Children',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc("parentID")
              .collection('children')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Text(
                'No Children Available',
                style: TextStyle(color: Colors.grey),
              );
            }

            var children = snapshot.data!.docs.map((doc) {
              return doc.data() as Map<String, dynamic>;
            }).toList();

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: children.length,
              itemBuilder: (context, index) {
                var child = children[index];
                return _buildChildCard(context, child);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildChildCard(BuildContext context, Map<String, dynamic> child) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentCoursePage(studentId: child['id']),
          ),
        );
      },
      child: Container(
        height: 80,
        width: 164,
        decoration: BoxDecoration(
          color: const Color(0xFF182243),
          borderRadius: BorderRadius.circular(21),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/user.png', height: 50, width: 50),
            const SizedBox(height: 10),
            Text(
              child['name'] ?? 'Unknown',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Level ${child['level'] ?? 'N/A'}',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableTeachersSection(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Available Teachers',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(parendId)
              .collection('teachers')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Text(
                'No Teachers Available',
                style: TextStyle(color: Colors.grey),
              );
            }

            var teachers = snapshot.data!.docs.map((doc) {
              return TeacherModel.fromMap(doc.data() as Map<String, dynamic>);
            }).toList();

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: teachers.length,
              itemBuilder: (context, index) {
                return _buildTeacherCard(context, teachers[index]);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildTeacherCard(BuildContext context, TeacherModel teacher) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(teacher: teacher),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 4),
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
                    'MR: ${teacher.teacherName}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Subject: ${teacher.subjectName}'),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                // Perform a call action
              },
              child: const Text('Call'),
            ),
          ],
        ),
      ),
    );
  }
}
