import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';

class VideoShowDetails extends StatelessWidget {
  const VideoShowDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Spacer(
                    flex: 2,
                  ),
                  GestureDetector(
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
            const SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.asset("assets/Rectangle 26.png"),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (conteext, index) => VideosPlaylist())
          ],
        ),
      ),
    );
  }
}

class VideosPlaylist extends StatelessWidget {
  const VideosPlaylist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
