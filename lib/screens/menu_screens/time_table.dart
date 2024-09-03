import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';

class TimetableScreen extends StatefulWidget {
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(centerWidget: Text("Time Table",style: TextStyle(color: Colors.white,fontSize: 25),)),
          // Days of the week as Tabs
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.blue,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelPadding: EdgeInsets.symmetric(vertical: 10.0),
              indicatorPadding: EdgeInsets.symmetric(horizontal: 10.0),
              tabs: [
                Text("Sat"),
                Text("Sun"),
                Text("Mon"),
                Text("Tue"),
                Text("Wed"),
                Text("Thu"),
                Text("Fri"),
              ],
            ),
          ),

          // Timetable details for each day
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(child: Text('Saturday Timetable')),
                Center(child: Text('Sunday Timetable')),
                Center(child: Text('Monday Timetable')),
                Center(child: Text('Tuesday Timetable')),
                // Here you would add the actual content like in the image you provided
                Column(
                  children: [
                       ListTile(
                        title: Text('Science'),
                        subtitle: Text('Basic Of Science Ch 1'),
                        trailing: Text('9:00 AM'),

                    ),
                    ListTile(
                      title: Text('Math'),
                      subtitle: Text('Intro Of Math Ch 2'),
                      trailing: Text('10:00 AM'),
                    ),
                  ],
                ),
                Center(child: Text('Thursday Timetable')),
                Center(child: Text('Friday Timetable')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class TimeTableCardList extends StatelessWidget {
  const TimeTableCardList({
  super.key,
  });

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
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  'Exam Name',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                ),
                Text(
                  '22-02-2024',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
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
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
