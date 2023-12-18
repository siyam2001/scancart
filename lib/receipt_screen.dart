import 'package:flutter/material.dart';
import 'package:scancartpro/payment_screen.dart'; // Import the payment screen file

class ReceiptScreen extends StatelessWidget {
  final List<String> cartItems;

  const ReceiptScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Receipt Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Display cart items and their details
            for (int i = 0; i < cartItems.length; i++)
              Text('${i + 1}. ${cartItems[i]}'),
            SizedBox(height: 20),
            Text(
              'Total Amount: \$100.00', // Replace with your logic to calculate the total amount
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the payment screen when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(),
                  ),
                );
              },
              child: Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
