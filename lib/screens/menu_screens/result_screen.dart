import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/models/result_model.dart';
import 'package:task/components/default_appbar.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              centerWidget: Text(
                "Results",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc('userId').collection('results').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final results = snapshot.data!.docs
                    .map((doc) => Result.fromDocument(doc))
                    .toList();

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: results.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ResultCardList(result: results[index]),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ResultCardList extends StatelessWidget {
  final Result result;

  const ResultCardList({
    required this.result,
    Key? key,
  }) : super(key: key);

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
            SizedBox(width: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  result.examName, // Display exam name
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  result.date, // Display exam date
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  result.type, // Display type of the exam
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                Text(
                  result.state == 'Passed' ? 'Pass' : 'Fail', // Display Pass/Fail
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Grade',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                Text(
                  '${result.grade}', // Display grade
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Percentage',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                Text(
                  '${result.percentage}%', // Display percentage
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
