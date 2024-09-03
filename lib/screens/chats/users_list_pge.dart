import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/screens/chats/chat_screen.dart';

class UsersListPage extends StatelessWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(centerWidget: Center(child: Text(" Chat ",style: TextStyle( color: Colors.white,fontWeight: FontWeight.w700,fontSize: 32),)))
         ,Container(
              padding: EdgeInsets.all(10),
           child: ListView.builder(
             shrinkWrap: true,
             physics: NeverScrollableScrollPhysics(),
             itemCount: 6, // Adjust this to the number of items you want
             itemBuilder: (BuildContext context, int index) {
               return GestureDetector(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage() ));
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
                               'assets/user.png', // Replace with your image asset path
                               width: 70,
                               height: 70,
                             ),
                             const SizedBox(height: 8),
                             const Text('MR : Ahmed'),
                           ],
                         ),
                         Column(
                           children: [
                             const Text(
                               'Science Teacher',
                               style: TextStyle(fontSize: 16),
                             ),
                             SizedBox(height: 20,),
                             const Text(
                               '25 Mar',
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
           )
        
            ),
          ],
        ),
      ),
    );
  }
}
