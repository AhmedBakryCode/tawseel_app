import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/screens/login/parent_login_screen.dart';
import 'package:task/screens/settings/add_childern_page.dart';
import 'package:task/screens/settings/childern_page.dart';
import 'package:task/screens/settings/payment_medthod.dart';
import 'package:task/screens/settings/profile_page.dart';

import '../../main.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
              centerWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                              "Settings",
                              style: TextStyle(
                    color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
                            ),
            IconButton(
              icon: Icon(
                MyApp.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
                size: 40,
              ),
              onPressed: () {
                // Toggle the theme using ValueNotifier
                MyApp.isDarkMode.value = !MyApp.isDarkMode.value;
              },
            ),
         ]),),
          SizedBox(
            height: 20,
          ),
          DefaultListTile(onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage())); }, icon: Icons.person, title: 'Profile',)
        ,DefaultListTile(onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context)=> AddChildernPage())); }, icon: Icons.supervisor_account_sharp, title: "Add Child")
,DefaultListTile(onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentMethod())); }, icon: Icons.credit_card, title: "Payment Method"),
          DefaultListTile(onTap: () {  }, icon: Icons.language, title: "Language"),
          DefaultListTile(onTap: () {  }, icon: Icons.privacy_tip, title: "Privacy"),
       DefaultListTile(onTap: () {  }, icon: Icons.call, title: "Contact Us"),
     DefaultListTile(onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context)=> ParentLoginScreen())); }, icon: Icons.logout, title: "Log Out")
        ],
      ),
    );
  }
}


class DefaultListTile extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;
  final String title;

  const DefaultListTile({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      onTap: onTap,
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: isDarkMode? Colors.white: Color(0xff130F44),
      ),
      leading: CircleAvatar(
        backgroundColor: Color(0xff130F44),
        child: Icon(icon, color: Colors.white),
        radius: 20,
      ),
      title: Text(
        title,
        style: TextStyle(color:isDarkMode? Colors.white: Color(0xff130F44), fontSize: 12),
      ),
    );
  }
}
