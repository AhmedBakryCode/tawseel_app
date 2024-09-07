import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/components/default_buttom.dart';
import 'package:task/components/default_textform_field.dart';
import 'package:task/screens/settings/address_;page.dart';

class AddAdressPage extends StatelessWidget {
  const AddAdressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _address=TextEditingController();
    TextEditingController _citycontroller=TextEditingController();
    TextEditingController _statecontroller=TextEditingController();
    TextEditingController _zipcodecontroller=TextEditingController();
    TextEditingController _phonecontroller=TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    _submitForm() {
      if (_formKey.currentState!.validate()) {
        // Form is valid, proceed with submission
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddressPage()),
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
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomAppBar(centerWidget: Text("Address", style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w700,
      ),)),
      SizedBox(height: 10,),
      Form(
key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 30,),
            CustomTextFormField(isPassword: false, controller: _address, hintText: "Address",validator: (valu){
              if(valu.isEmpty){
                return "this field is required";
              }
              else
                { return null;}
            },),
            SizedBox(height: 10,),
            CustomTextFormField(isPassword: false, controller: _citycontroller, hintText: "City"),
            SizedBox(height: 10,),
            CustomTextFormField(isPassword: false, controller: _statecontroller, hintText: "State/Providence"),
            SizedBox(height: 10,),
            CustomTextFormField(isPassword: false, controller: _zipcodecontroller, hintText: "Zip code(Postal code)"),
            SizedBox(height: 10,),
            CustomTextFormField(isPassword: false, controller: _phonecontroller, hintText: "Phone"),
            SizedBox(height: 20,),
            CustomButton(text: "SAVE ADDRESS", onPressed:  _submitForm)
          ],
        ),
      ),

    ],
  ),
),
    );
  }
}
