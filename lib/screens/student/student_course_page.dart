import 'package:flutter/material.dart';
import 'package:task/components/custom_item_menu.dart';
import 'package:task/components/default_appbar.dart';

class StudentCoursePage extends StatefulWidget {
  const StudentCoursePage({Key? key}) : super(key: key);

  @override
  State<StudentCoursePage> createState() => _StudentCoursePageState();
}

class _StudentCoursePageState extends State<StudentCoursePage> {
  @override
  Widget build(BuildContext context) {
    bool isMenuOpen = false;

    void toggleMenu() {
      setState(() {
        isMenuOpen = !isMenuOpen;
      });
    }

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        body: Column(
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
                      ],
                    ),
                  ),
    Positioned(
    top: 100, // Adjust as needed
    right: 20, // Adjust as needed
    child: GestureDetector(
    onTap: toggleMenu,
    child: Icon(
    Icons.menu,
    size: 30,
    color: Colors.white,
    ),
    ),
    ),

    // The dropdown menu
    if (isMenuOpen)
    Positioned(
    top: 140, // Adjust this value to align with your button
    right: 20,
    child: Material(
    color: Colors.transparent,
    child: Container(
    width: 250, // Ensure this matches the width of your menu
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
    child: Column(
    children: [
    _buildMenuItem(Icons.people, 'Teachers'),
    _buildMenuItem(Icons.visibility, 'Attendance'),
    _buildMenuItem(Icons.assignment, 'Assignments'),
    _buildMenuItem(Icons.schedule, 'Time Table'),
    _buildMenuItem(Icons.edit, 'Exams'),
    _buildMenuItem(Icons.print, 'Result'),
    ],
    ),
    ),
    ),
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
                  Center(child: Text('Tracking Tab Content')),
                ],
              ),
            ),
          ],

    )));}

  void _onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        print("Profile clicked");
        break;
      case 1:
        print("Settings clicked");
        break;
      case 2:
        print("Logout clicked");
        break;
    }
  }
}

class SubjectsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of columns
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return GridTile(
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
Widget _buildMenuItem(IconData icon, String title) {
  return Container(
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
  );
}
