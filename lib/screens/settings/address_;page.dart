import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/screens/settings/add_address.dart';
import 'package:task/models/address_model.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  List<bool> isCheckedList = [];

  // Fetch addresses from Firestore
  Future<List<AddressModel>> fetchAddresses() async {
    String userId = 'authenticated_user_id'; // Replace with FirebaseAuth logic
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('parent')
        .doc('address')
        .collection('addressList') // Ensure structure matches your Firestore
        .get();

    return querySnapshot.docs.map((doc) {
      return AddressModel.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAdressPage()),
          );
        },
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Color(0xff130F44),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              centerWidget: Text(
                "Address",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<AddressModel>>(
              future: fetchAddresses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No addresses found.'));
                }

                List<AddressModel> addresses = snapshot.data!;
                isCheckedList = List<bool>.filled(addresses.length, false);

                return ListView.builder(
                  itemCount: addresses.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    AddressModel address = addresses[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          address.address,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '${address.city}, ${address.stateOrRegion}, ${address.zipCode}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text('Phone: ${address.phone}'),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddAdressPage(
                                            address: address,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Checkbox(
                                    value: isCheckedList[index],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isCheckedList[index] = value!;
                                      });
                                    },
                                  ),
                                  Text('Use as the shipping address'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
