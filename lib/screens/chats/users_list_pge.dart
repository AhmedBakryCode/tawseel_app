import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/models/teacher_model.dart';
import 'package:task/screens/chats/chat_screen.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  _UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<List<TeacherModel>> _teachers;

  @override
  void initState() {
    super.initState();
    _teachers = fetchTeachers();
  }

  Future<List<TeacherModel>> fetchTeachers() async {
    // Assuming 'users' is your main collection and 'teachers' is a subcollection
    final QuerySnapshot usersSnapshot = await _firestore.collection('users').get();

    List<TeacherModel> teachersList = [];

    for (var userDoc in usersSnapshot.docs) {
      // Fetching the 'teachers' subcollection for each user
      final QuerySnapshot teachersSnapshot = await _firestore
          .collection('users')
          .doc(userDoc.id)
          .collection('teachers')
          .get();

      // Adding teachers to the list
      teachersList.addAll(teachersSnapshot.docs
          .map((doc) => TeacherModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList());
    }

    return teachersList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              centerWidget: Center(
                child: Text(
                  "Chat",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 32),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: FutureBuilder<List<TeacherModel>>(
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
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: teachers.length,
                    itemBuilder: (BuildContext context, int index) {
                      final teacher = teachers[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChatPage( teacher: teacher,)),
                          );
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/user.png", // Adjust according to your model
                                      width: 70,
                                      height: 70,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(teacher.teacherName),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      teacher.subjectName,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      teacher.mobilePhone,
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
