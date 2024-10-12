import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/models/attendance_model.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<List<AttendanceModel>> _attendanceData;

  @override
  void initState() {
    super.initState();
    _attendanceData = fetchAttendance();
  }

  Future<List<AttendanceModel>> fetchAttendance() async {
    final QuerySnapshot snapshot = await _firestore.collection('attendance').get(); // Ensure 'attendance' is your collection name
    return snapshot.docs
        .map((doc) => AttendanceModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            centerWidget: Text(
              "Attendance",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder<List<AttendanceModel>>(
                future: _attendanceData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No attendance data found.'));
                  }

                  final attendanceList = snapshot.data!;

                  int totalPresent = attendanceList.where((attendance) => attendance.isPresent).length;
                  int totalAbsent = attendanceList.length - totalPresent;

                  return Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.green,
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                right: 100,
                                left: 100,
                                child: Text(
                                  "Total Present",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ),
                              Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 50,
                                  child: Text(
                                    "$totalPresent",
                                    style: TextStyle(fontSize: 50, color: Colors.green),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Image.asset("assets/happy.png"),
                                bottom: 20,
                                right: 0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.red,
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                right: 100,
                                left: 100,
                                child: Text(
                                  "Total Absent",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ),
                              Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 50,
                                  child: Text(
                                    "$totalAbsent",
                                    style: TextStyle(fontSize: 50, color: Colors.red),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Image.asset("assets/unhappy.png"),
                                bottom: 20,
                                left: 0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
