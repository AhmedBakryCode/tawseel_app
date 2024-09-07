import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/screens/student/live_location_page.dart';

class DriverDetailsPage extends StatelessWidget {
  const DriverDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveLocationPAge()));
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:  Color(0xff182243)),
          child: Icon(Icons.videocam,color: Colors.white,),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomAppBar(
              centerWidget: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Row(children: [
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
                  ],),
Spacer(flex: 1,),
                  GestureDetector(
                    onTap: (){},
                    child: Icon(
                      Icons.sort,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Driver ",style: TextStyle(color: Colors.black,fontSize: 20),),
                    ],
                  ),
                  DefaultDriverCard(),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("Live Location",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700),),
                    ],

                  ),
                  SizedBox(height: 20,),
                  Container(height: MediaQuery.of(context).size.height*0.3,padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child:Image.asset("assets/Rectangle 24.png") ,),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DefaultDriverCard extends StatelessWidget {
  const DefaultDriverCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("Mahmoud",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Text("Nationality: egypt",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                ],
              ),
              Image.asset("assets/user.png",height: 100,width: 100,)
            ],
          ),
          Row(
            children: [
              Text("ID 258963",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ],
          ),
          Row(
            children: [
              Text("I lisence: 456879",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ],
          ),
          Row(
            children: [
              Text("Phone: 0123456789",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ],
          )
        ],
      ),
    );
  }
}
