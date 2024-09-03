import 'package:flutter/material.dart';

class DefaultListTile extends StatelessWidget {
  final IconData icon;
  final String title;

  DefaultListTile({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color(0xff182243),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Color(0xff182243),
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff182243)),
      onTap: () {
        // Add your onTap function here
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Default ListTile Component'),
        backgroundColor: Color(0xff182243),
      ),
      body: ListView(
        children: [
          DefaultListTile(
            icon: Icons.person,
            title: 'Profile',
          ),
          DefaultListTile(
            icon: Icons.settings,
            title: 'Settings',
          ),
          DefaultListTile(
            icon: Icons.logout,
            title: 'Logout',
          ),
        ],
      ),
    ),
  ));
}
