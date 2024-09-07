import 'package:flutter/material.dart';

import '../../components/default_appbar.dart';

class ChapterDetailsPage extends StatelessWidget {
  const ChapterDetailsPage({Key? key}) : super(key: key);

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
                      child: Center(child: Text("Files")),
                    ),
                    Container(
                      height: 50, // Set the height of the tab
                      child: Center(child: Text("Videos")),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6, // Constrain height for TabBarView
                child: TabBarView(
                  children: [
                    FilesTabBar(),
                    VideosTabBar(),
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

class FilesTabBar extends StatelessWidget {
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
                      'intro to Chapter 1.pdf',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Icon(Icons.folder_open_sharp,size: 20,)                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VideosTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   ListView.builder(itemCount: 6,itemBuilder: (context,index)=>   Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white, // Background color of the card
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // shadow direction: bottom right
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text section
          Expanded(
            child: Text(
              'Basic Of Science Ch 1',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16, // Adjusted font size for better appearance
              ),
            ),
          ),
          // Image section
          Container(
            height: 60, // Adjusted height to match the example
            width: 100, // Adjusted width to match the example
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage("assets/Rectangle 26.png"),
                fit: BoxFit.cover, // Ensures the image fits properly
              ),
            ),
          ),
        ],
      ),
    ),
    
    );
  }
}
