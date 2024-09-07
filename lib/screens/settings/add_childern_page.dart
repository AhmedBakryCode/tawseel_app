import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/components/default_buttom.dart';
import 'package:task/screens/settings/childern_page.dart';

import '../../components/default_textform_field.dart';

class AddChildernPage extends StatefulWidget {
  const AddChildernPage({Key? key}) : super(key: key);

  @override
  State<AddChildernPage> createState() => _AddChildernPageState();
}

class _AddChildernPageState extends State<AddChildernPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _namecontroller=TextEditingController();
    TextEditingController _idcontroller=TextEditingController();
    TextEditingController _gendercontroller=TextEditingController();
    TextEditingController _levelcontroller=TextEditingController();
    TextEditingController _birthdatecontroller=TextEditingController();
    TextEditingController _phonecontroller=TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    _submitForm() {
      if (_formKey.currentState!.validate()) {
        // Form is valid, proceed with submission
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChildernPage()),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fix the errors in red')),
        );
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomAppBar(centerWidget: Text("Child",style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),)),
            Align(alignment: Alignment.center,child: Image.asset("assets/user.png",height: 100,width: 100,fit: BoxFit.fill,),),
            Form(key: _formKey,child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextFormField(isPassword: false, controller: _namecontroller, hintText: "Name",validator: (valu){
                  if(valu.isEmpty){
                    return "this field is required";
                  }
                  else
                  { return null;}
                },),
                SizedBox(height: 10,),
                CustomTextFormField(isPassword: false, controller: _idcontroller, hintText: "ID",validator: (valu){
                  if(valu.isEmpty){
                    return "this field is required";
                  }
                  else
                  { return null;}
                },),
                SizedBox(height: 10,),
                DropdownTextFormField(controller: _gendercontroller, hintText: "Gender", dropdownItems: ["Male","Female","prefer not to say"]),
              SizedBox(height: 10,),
                DropdownTextFormField(controller: _levelcontroller, hintText: "Level", dropdownItems: ["1","2","3","4"]),
    SizedBox(height: 10,),
Text("Date of Birthday"),
    SizedBox(height: 10,),
    BirthDateField(controller: _birthdatecontroller),
    SizedBox(height: 10,),
    CustomTextFormField(isPassword: false, controller: _phonecontroller, hintText: "phone",validator: (valu){
                  if(valu.isEmpty){
                    return "this field is required";
                  }
                  else
                  { return null;}
                },),
    SizedBox(height: 20,),

    CustomButton(text: "ADD", onPressed:_submitForm )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
