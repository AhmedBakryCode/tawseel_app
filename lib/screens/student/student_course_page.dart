import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:task/components/custom_item_menu.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/screens/menu_screens/assignments_screen.dart';
import 'package:task/screens/menu_screens/attendance_screen.dart';
import 'package:task/screens/menu_screens/exam_screen.dart';
import 'package:task/screens/menu_screens/result_screen.dart';
import 'package:task/screens/menu_screens/teachers_screen.dart';
import 'package:task/screens/menu_screens/time_table.dart';
import 'package:task/screens/student/driver_details_page.dart';

import '../student_sunject/student_subject_page.dart';

class StudentCoursePage extends StatefulWidget {
  const StudentCoursePage({Key? key}) : super(key: key);

  @override
  State<StudentCoursePage> createState() => _StudentCoursePageState();
}

class _StudentCoursePageState extends State<StudentCoursePage> {
  bool isMenuOpen = false;

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomAppBar(
                  centerWidget: Stack(
                    children: [
                      Row(
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
                              ],
                            ),
                          ),
                          const Spacer(flex: 1,),
                          GestureDetector(
                            onTap: toggleMenu,
                            child: Icon(
                              Icons.sort,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          // The dropdown menu


                        ],
                      ),


                    ],
                  ),

                ),
                Container(
                  color: Colors.white, // This will make the tabs' background color white.
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: Color(0xff182243), // Color for the selected tab.
                      borderRadius: BorderRadius.circular(12), // Rounded corners for the selected tab.
                    ),
                    labelColor: Colors.white, // Text color for the selected tab.
                    unselectedLabelColor: Colors.black, // Text color for the unselected tabs.
                    tabs: [
                      Container(
                        height: 50, // Set the height of the tab.
                        child: Center(child: Text("Subjects")),
                      ),
                      Container(
                        height: 50, // Set the height of the tab.
                        child: Center(child: Text("Tracking")),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      SubjectsGrid(),
                      TrackingPage(),
                    ],
                  ),
                ),
              ],
            ),
            if (isMenuOpen)
              Positioned(
                top: 80, // Adjust the top to position the menu under the icon
                right: 20, // Add padding from the right edge to avoid overflow
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 250, // Set a fixed width for the dropdown menu
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.6, // Limit height to 50% of the screen
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView( // Make the dropdown scrollable if content is too long
                      child: Column(
                        children: [
                          _buildMenuItem(icon:Icons.people, title: 'Teachers',ontap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>TeacherPage())); }),
                          _buildMenuItem(icon:Icons.visibility_outlined, title: 'Attendance',ontap:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>AttendanceScreen())); } ),
                          _buildMenuItem(icon: Icons.book_outlined, title: 'Assignments',ontap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>AssignmentsPage())); }),
                          _buildMenuItem(icon: Icons.alarm, title: 'Time Table',ontap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>TimetableScreen())); }),
                          _buildMenuItem(icon:Icons.edit,title: 'Exams',ontap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ExamPage())); }),
                          _buildMenuItem(icon:Icons.print,title: 'Result',ontap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultPage())); }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }
}

class TrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Live Location",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: Image.asset("assets/Rectangle 24.png"),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Tips",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) => TrackCardList(),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectsGrid extends StatelessWidget {
  final int? itemCount;

  SubjectsGrid({this.itemCount}); // Optional parameter for item count

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of columns
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: itemCount ?? subjects.length, // If itemCount is null, show the entire list
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StudentSubjectChapter()));
            },
            child: GridTile(
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      subjects[index]['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(subjects[index]['name']!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

List<Map<String, String>> subjects = [
  {'name': 'Science', 'image': 'assets/Rectangle 21.png'},
  {'name': 'English', 'image': 'assets/Rectangle 21.png'},
  {'name': 'Arabic', 'image': 'assets/Rectangle 21.png'},
  {'name': 'Math', 'image': 'assets/Rectangle 21.png'},
  {'name': 'Drawing', 'image': 'assets/Rectangle 21.png'},
  {'name': 'Computer', 'image': 'assets/Rectangle 21.png'},
  {'name': 'Account', 'image': 'assets/Rectangle 21.png'},
  {'name': 'Math 2', 'image': 'assets/Rectangle 21.png'},
  {'name': 'French', 'image': 'assets/Rectangle 21.png'},
];

Widget _buildMenuItem({IconData? icon,required String title, Function()? ontap}) {
  return GestureDetector(
    onTap:ontap ,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xff182243),
            radius: 20,
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff182243),
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, color: Color(0xff182243)),
        ],
      ),
    ),
  );
}

class TrackCardList extends StatelessWidget {
  const TrackCardList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DriverDetailsPage()));
      },
      child: Container(
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
              SizedBox(width: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Driver : Mahmoud',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Running',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'inside',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                  Text(
                    'Aswan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
