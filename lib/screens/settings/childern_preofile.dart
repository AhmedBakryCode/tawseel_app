import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/components/default_textform_field.dart';
import 'package:task/screens/settings/add_childern_page.dart';
import 'package:task/screens/settings/address_;page.dart';
import 'package:task/screens/settings/change_password.dart';
import 'package:task/screens/settings/childern_page.dart';
import 'package:task/screens/settings/my_cart_page.dart';
import 'package:task/screens/settings/payment_medthod.dart';
import 'package:task/screens/settings/settings_page.dart';

import '../../components/default_buttom.dart';

class ChildernProfilePage extends StatelessWidget {
  const ChildernProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(centerWidget: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [const SizedBox(width: 20,),
              CircleAvatar(
                backgroundColor: Color(0xff182243),
                radius: 30,
                child: Image.asset("assets/user.png"),
              ),
              const SizedBox(width: 10),
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

                    Text(
                      "mohamed@gmail.com",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),

                  ],
                ),
              ),],
          )),
          DefaultListTile(onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage() ));}, icon: Icons.person, title: "Address"),
          DefaultListTile(onTap: (){
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
              ),
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: AddNewCardDialog(),
                );
              },
            );}, icon: Icons.edit, title: "Change Password"),
        ],
      ),
    );
  }
}
