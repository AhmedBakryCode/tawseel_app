import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/components/default_buttom.dart';
import 'package:task/components/default_textform_field.dart';
import 'package:task/models/address_model.dart';

class AddAdressPage extends StatelessWidget {
  final AddressModel? address; // Optional address for editing
  AddAdressPage({this.address, Key? key}) : super(key: key);

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (address != null) {
      // Populate controllers if editing
      _addressController.text = address!.address;
      _cityController.text = address!.city;
      _stateController.text = address!.stateOrRegion;
      _zipCodeController.text = address!.zipCode;
      _phoneController.text = address!.phone;
    }

    _submitForm() async {
      if (_formKey.currentState!.validate()) {
        final newAddress = AddressModel(
          address: _addressController.text,
          city: _cityController.text,
          stateOrRegion: _stateController.text,
          zipCode: _zipCodeController.text,
          phone: _phoneController.text,
        );

        final addressCollection = FirebaseFirestore.instance
            .collection('users')
            .doc('parentId') // Replace with dynamic user ID
            .collection('addresses');

        if (address == null) {
          // Add new address
          await addressCollection.add(newAddress.toMap());
        } else {
          // Update existing address
          await addressCollection
              .doc(addressCollection.id) // Assuming `id` field exists in model
              .update(newAddress.toMap());
        }

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fix the errors in red')),
        );
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              centerWidget: const Text(
                "Address",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    controller: _addressController,
                    hintText: "Address",
                    validator: (value) =>
                    value!.isEmpty ? "This field is required" : null, isPassword: false,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(controller: _cityController, hintText: "City", isPassword: false,),
                  const SizedBox(height: 10),
                  CustomTextFormField(controller: _stateController, hintText: "State", isPassword: false,),
                  const SizedBox(height: 10),
                  CustomTextFormField(controller: _zipCodeController, hintText: "Zip Code", isPassword: false,),
                  const SizedBox(height: 10),
                  CustomTextFormField(controller: _phoneController, hintText: "Phone", isPassword: false,),
                  const SizedBox(height: 20),
                  CustomButton(text: "SAVE ADDRESS", onPressed: _submitForm),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
