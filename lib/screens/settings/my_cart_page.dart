import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/components/default_buttom.dart';
import 'package:task/models/my_cart.dart';
import 'package:task/screens/settings/payment_medthod.dart';

class MyCartPage extends StatelessWidget {
  final String parentId; // Add this to pass parentId dynamically.

  const MyCartPage({Key? key, required this.parentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomAppBar(
              centerWidget: Text(
                "My Cart",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(parentId)
                  .collection('cart')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      'No Items in the Cart',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  );
                }

                // Map Firestore data to CartItem objects
                var cartItems = snapshot.data!.docs
                    .map((doc) => CartItem.fromMap(doc.data() as Map<String, dynamic>))
                    .toList();

                double totalAmount = cartItems.fold(
                  0.0,
                      (sum, item) => sum + item.amount,
                );

                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return DefaultCartCard(cartItem: cartItems[index]);
                      },
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Total Amount: ${totalAmount.toStringAsFixed(2)}\$",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    CustomButton(
                      text: "Check Out",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentMethod()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DefaultCartCard extends StatelessWidget {
  final CartItem cartItem;

  const DefaultCartCard({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Nationality: ${cartItem.nationality}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Image.asset("assets/user.png", height: 100, width: 100),
            ],
          ),
          Row(
            children: [
              Text(
                "Level: ${cartItem.level}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Amount: ${cartItem.amount.toStringAsFixed(2)}\$",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
