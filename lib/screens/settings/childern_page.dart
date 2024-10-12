import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/models/child_model.dart';

class ChildernPage extends StatelessWidget {
  const ChildernPage({Key? key}) : super(key: key);

  Future<List<Child>> fetchChildren() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc('parentID') // Replace with actual parent ID
        .collection('children')
        .get();

    return snapshot.docs.map((doc) => Child.fromFirestore(doc.data())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Child>>(
        future: fetchChildren(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No children found'));
          }

          final children = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(
                  centerWidget: Text(
                    "Children",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: children.length,
                  itemBuilder: (context, index) =>
                      CardListItem(child: children[index]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
class CardListItem extends StatelessWidget {
  final Child child;

  const CardListItem({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  'assets/user.png', // Replace with your image asset path
                  width: 100,
                  height: 100,
                ),
                SizedBox(width: 10),
                Text(
                  'Name: ${child.name}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Level: ${child.level}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Text('Phone: ${child.phone}'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Gender: ${child.gender}'),
                Text('Birth Date: ${child.birthDate}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
