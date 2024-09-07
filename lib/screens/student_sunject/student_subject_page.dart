import 'package:flutter/material.dart';
import 'package:task/screens/student_sunject/student_chapter_details.dart';

import '../../components/default_appbar.dart';

class StudentSubjectChapter extends StatelessWidget {
  const StudentSubjectChapter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                centerWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xff182243),
                          radius: 35,
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
                      ],
                    ),
Spacer(flex: 2,),                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.sort,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                color: Colors.white, // Tabs' background color
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Color(0xff182243), // Color for the selected tab
                    borderRadius: BorderRadius.circular(12), // Rounded corners for the selected tab
                  ),
                  labelColor: Colors.white, // Text color for the selected tab
                  unselectedLabelColor: Colors.black, // Text color for the unselected tabs
                  tabs: [
                    Container(
                      height: 50, // Set the height of the tab
                      child: Center(child: Text("Chapters")),
                    ),
                    Container(
                      height: 50, // Set the height of the tab
                      child: Center(child: Text("Announcements")),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6, // Constrain height for TabBarView
                child: TabBarView(
                  children: [
                    ChaptersTabBar(),
                    AnnouncementTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChaptersTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChapterDetailsPage()),
          );

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
                      'Exam Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '22-02-2024',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mid Year',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    Text(
                      '09: 15 AM',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnnouncementTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   ListView.builder(itemCount: 6,itemBuilder: (context,index)=>   Card(
          child: Container(margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
            child: Column(
              children: [
                Align(alignment: Alignment.centerLeft,
                  child: Text("Assignment 1",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),),
                ),
                SizedBox(height: 10),
                Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'intro to Chpter 1.pdf',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Icon(
                          Icons.folder_open_sharp,
                          size: 20,
                        ),
                      ],
                    ),
              ],
            ),
          ),
    )
    );
  }
}
