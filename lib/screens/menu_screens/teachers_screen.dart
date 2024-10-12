import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/models/teacher_model.dart';
import 'package:task/screens/chats/chat_screen.dart'; // Ensure this points to your modified ChatPage

class TeacherPage extends StatefulWidget {
  const TeacherPage({Key? key}) : super(key: key);

  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<List<TeacherModel>> _teachers;

  @override
  void initState() {
    super.initState();
    _teachers = fetchTeachers();
  }

  Future<List<TeacherModel>> fetchTeachers() async {
    final QuerySnapshot snapshot = await _firestore.collection('teachers').get();
    return snapshot.docs
        .map((doc) => TeacherModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              centerWidget: Text(
                "Teachers",
                style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<TeacherModel>>(
              future: _teachers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No teachers found.'));
                }

                final teachers = snapshot.data!;

                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: teachers.length,
                  itemBuilder: (context, index) {
                    final teacher = teachers[index];
                    return Container(
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
                                  'assets/user.png', // Default image
                                  width: 100,
                                  height: 100,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      teacher.teacherName,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(teacher.subjectName),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatPage(teacher: teacher), // Pass the teacher parameter
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.message,
                                    color: Color(0xff3A3A3A),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(teacher.mobilePhone), // Display the mobile phone number
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
