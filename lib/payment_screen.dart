import 'package:flutter/material.dart';
import 'package:scancartpro/payment_success_screen.dart';
import 'package:scancartpro/CardEntryScreen.dart'; // Make sure you have this import statement


class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPaymentMethod = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Payment Method:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('Cash Payment'),
              leading: Radio(
                value: 'Cash',
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value as String;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Card Payment'),
              leading: Radio(
                value: 'Card',
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value as String;
                  });

                  if (selectedPaymentMethod == 'Card') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CardEntryScreen(),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await Future.delayed(Duration(seconds: 1));

                if (selectedPaymentMethod == 'Cash') {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Payment Successful'),
                      content: Text('Thank you for your cash payment.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentSuccessScreen(),
                              ),
                            );
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentSuccessScreen(),
                    ),
                  );
                }
              },
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
