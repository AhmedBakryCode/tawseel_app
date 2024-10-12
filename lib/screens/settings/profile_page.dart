import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/components/default_textform_field.dart';
import 'package:task/screens/settings/add_childern_page.dart';
import 'package:task/screens/settings/address_;page.dart';
import 'package:task/screens/settings/change_password.dart';
import 'package:task/screens/settings/childern_page.dart';
import 'package:task/screens/settings/my_cart_page.dart';
import 'package:task/screens/settings/settings_page.dart';

import '../../components/default_buttom.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  Future<String?> getParentId() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Assuming the user's document ID matches the Firebase Auth user UID
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        return doc.id; // This will be the parentId
      }
    } catch (e) {
      print('Error retrieving parentId: $e');
    }
    return null;
  }
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
          DefaultListTile(icon:Icons.supervisor_account_sharp , title: "Childern", onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>ChildernPage() ));},),
          DefaultListTile(onTap:  ()async{             String? parentId = await getParentId(); // Fetch parentId

          if (parentId != null) {
            // Navigate to MyCartPage and pass parentId
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyCartPage(parentId: parentId),
              ),
            );
          } else {
            // Handle case where parentId is null (e.g., show an error message)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to retrieve parentId')),
            );
          }
          ;}, icon: Icons.shopping_cart, title: "Cart"),
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
class AddNewCardDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _oldpassword = TextEditingController();
    TextEditingController _newpassword = TextEditingController();
    TextEditingController _repeatpassword = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    _submitForm() {
      if (_formKey.currentState!.validate()) {
        // Form is valid, proceed with submission
        Navigator.pop(context);

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fix the errors in red')),
        );
      }
    }

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 10),
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Change Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                  isPassword: false,
                  controller: _oldpassword,
                  hintText: "Old Password"),
              SizedBox(height: 5,),
              Row(mainAxisAlignment: MainAxisAlignment.end,children: [Text("Forger password?",style: TextStyle(color: Colors.grey,fontSize: 10),)],),
              SizedBox(height: 20),
              CustomTextFormField(
                  isPassword: false,
                  controller: _newpassword,
                  hintText: "New Password"),
              SizedBox(height: 20),
              CustomTextFormField(
                  isPassword: false,
                  controller: _repeatpassword,
                  hintText: "Repeat New Password"),
              SizedBox(height: 20),
              SizedBox(height: 20),
              SizedBox(height: 20),
              CustomButton(text: "SAVE PASSWORD", onPressed: (){
                _submitForm();
              }),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
