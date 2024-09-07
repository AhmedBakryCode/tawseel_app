import 'package:flutter/material.dart';
import 'package:task/components/default_appbar.dart';
import 'package:task/components/default_buttom.dart';
import 'package:task/components/default_textform_field.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

int? selectedIndex;

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> cardDetails = [
      {
        'cardHolder': 'Jennyfer Doe',
        'expiryDate': '05/23',
        'cardNumber': '**** **** **** 3947',
      },
      {
        'cardHolder': 'John Smith',
        'expiryDate': '08/25',
        'cardNumber': '**** **** **** 1234',
      },
      // Add more cards as needed
    ];
    return Scaffold(
      floatingActionButton: GestureDetector(
          onTap: () {
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
            );
          },
          child: CircleAvatar(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Color(0xff222222),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
                centerWidget: Text(
              "Payment Method",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Your Payments Cards",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                  itemCount: cardDetails.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => PaymentCard(
                        isSelected: selectedIndex == index,
                        cardHolderName: cardDetails[index]['cardHolder']!,
                        expiryDate: cardDetails[index]['expiryDate']!,
                        cardNumber: cardDetails[index]['cardNumber']!,
                        onChanged: (bool? value) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      )),
            )
          ],
        ),
      ),
    );
  }
}

class PaymentCard extends StatefulWidget {
  final bool isSelected;
  final Function(bool?) onChanged;
  final String cardHolderName;
  final String expiryDate;
  final String cardNumber;

  PaymentCard({
    required this.isSelected,
    required this.onChanged,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cardNumber,
  });

  @override
  _PaymentCardState createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              height: 180, // Adjust height based on your needs
              decoration: BoxDecoration(
                color: Color(0xff222222),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    blurRadius: 5,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Top-right positioned image (Ellipse)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/Ellipse.png', // Top-right image asset
                      width: 100,
                      height: 100,
                    ),
                  ),
                  // Bottom-left positioned image (Card logo or design)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                      'assets/card.png', // Bottom-left image asset
                      width: 280,
                      height: 115,
                    ),
                  ),
                  // Card content
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Card chip or other design elements can be an image from assets
                            Container(
                              height: 25,
                              width: 32,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.amber),
                            ),
                            Spacer(),
                            Text(
                              widget.cardNumber,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Card Holder Name',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  widget.cardHolderName,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expiry Date',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  widget.expiryDate,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Grey overlay for unselected cards
            if (!widget.isSelected)
              Positioned.fill(
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
            // Checkbox section
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: widget.isSelected,
              onChanged: widget.onChanged,
              activeColor: Colors.black,
              checkColor: Colors.white,
            ),
            Text(
              'Use as default payment method',
              style: TextStyle(
                  color: widget.isSelected ? Colors.black : Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}

class AddNewCardDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _nameofcardcontroller = TextEditingController();
    TextEditingController _cardname = TextEditingController();
    TextEditingController _expdate = TextEditingController();
    TextEditingController _cvv = TextEditingController();
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
                'Add new card',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                  isPassword: false,
                  controller: _nameofcardcontroller,
                  hintText: "Name of Card"),
              SizedBox(height: 20),
              CustomTextFormField(
                  isPassword: false,
                  controller: _cardname,
                  hintText: "Card Number"),
              SizedBox(height: 20),
              CustomTextFormField(
                  isPassword: false,
                  controller: _expdate,
                  hintText: "Expiry date"),
              SizedBox(height: 20),
              CustomTextFormField(
                  isPassword: false, controller: _cvv, hintText: "CVV"),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (bool? value) {},
                  ),
                  Text('Set as default payment method'),
                ],
              ),
              SizedBox(height: 20),
              CustomButton(text: "ADD CARD", onPressed: (){
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
