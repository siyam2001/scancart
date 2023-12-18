import 'package:flutter/material.dart';
import 'package:scancartpro/payment_success_screen.dart';

class CardEntryScreen extends StatefulWidget {
  @override
  _CardEntryScreenState createState() => _CardEntryScreenState();
}

class _CardEntryScreenState extends State<CardEntryScreen> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Card Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: cardNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Card Number'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: expirationDateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(labelText: 'Expiration Date'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: cvvController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'CVV'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Validate card details (add your validation logic here)
                if (_validateCardDetails()) {
                  // Simulate a delay to simulate card validation and payment processing
                  await Future.delayed(Duration(seconds: 2));

                  // Navigate to the payment success screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentSuccessScreen(),
                    ),
                  );
                } else {
                  // Show an error message or handle invalid card details
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Invalid Card Details'),
                      content: Text('Please enter valid card details.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Submit Payment'),
            ),
          ],
        ),
      ),
    );
  }

  // Validate card details function (customize based on your validation requirements)
  bool _validateCardDetails() {
    return cardNumberController.text.isNotEmpty &&
        expirationDateController.text.isNotEmpty &&
        cvvController.text.isNotEmpty;
  }
}
