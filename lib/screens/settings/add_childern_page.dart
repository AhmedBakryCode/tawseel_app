import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _genderController = TextEditingController();
  final _levelController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Firestore instance
  final CollectionReference _parentCollection =
  FirebaseFirestore.instance.collection('users').doc('parentID').collection('children');

  Future<void> _addChild() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _parentCollection.add({
          'name': _nameController.text,
          'id': _idController.text,
          'gender': _genderController.text,
          'level': _levelController.text,
          'birth_date': _birthDateController.text,
          'phone': _phoneController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Child added successfully')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChildernPage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding child: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in red')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomAppBar(
              centerWidget: const Text(
                "Child",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/user.png",
                height: 100,
                width: 100,
                fit: BoxFit.fill,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextFormField(
                    isPassword: false,
                    controller: _nameController,
                    hintText: "Name",
                    validator: (value) {
                      if (value!.isEmpty) return "This field is required";
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    isPassword: false,
                    controller: _idController,
                    hintText: "ID",
                    validator: (value) {
                      if (value!.isEmpty) return "This field is required";
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  DropdownTextFormField(
                    controller: _genderController,
                    hintText: "Gender",
                    dropdownItems: ["Male", "Female", "Prefer not to say"],
                  ),
                  const SizedBox(height: 10),
                  DropdownTextFormField(
                    controller: _levelController,
                    hintText: "Level",
                    dropdownItems: ["1", "2", "3", "4"],
                  ),
                  const SizedBox(height: 10),
                  const Text("Date of Birthday"),
                  const SizedBox(height: 10),
                  BirthDateField(controller: _birthDateController),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    isPassword: false,
                    controller: _phoneController,
                    hintText: "Phone",
                    validator: (value) {
                      if (value!.isEmpty) return "This field is required";
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(text: "ADD", onPressed: _addChild),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
